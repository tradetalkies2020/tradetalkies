const Post = require("../models/Post");
const Repost = require("../models/Repost");
const User = require("../models/User");
const Comment = require("../models/comment");
const Ticker = require("../models/Tickers");
const Constants = require("../models/constants");
const userServices = require("../services/userservices");
const postServices = require("../services/postservices");
const logger = require("../middleware/logger");
const async = require("async");
const mongoose = require("mongoose");
const ObjectId = mongoose.Types.ObjectId;

exports.postNewPost = async (req, res, next) => {
    const currentUser = req.session.user;
    const tickers = req.body.tickers;
    const desc = req.body.desc;
    let images = [];

    //image handler//
    if (req.files !== undefined) {
        await req.files.forEach((file) => {
            images.push(file.location);
        });
    } else if (req.file !== undefined) {
        images.push(req.file.location);
    }

    //end image handler//

    const post = new Post({
        userId: currentUser._id,
        tickers: tickers,
        desc: desc,
        likes: [],
        images: images,
    });
    console.log(post);

    Constants.findOne({ name: "points" })
        .select("value")
        .then((pointSet) => {
            let postvalue = pointSet.value.post;
            let userPromise = userServices.addPoints(
                currentUser._id,
                postvalue
            );
            userPromise
                .then((result) => {
                    console.log(result);
                    if (result === true) {
                        post.save()
                            .then((result) => {
                                new Comment({
                                    postId: result._id,
                                    comments: [],
                                }).save((err, resul) => {
                                    if (err) {
                                        throw new Error(
                                            "Error in saving commentt"
                                        );
                                    }
                                    console.log(resul);
                                });
                                console.log(
                                    `Post created for userId :${currentUser._id}`
                                );
                                logger.info(
                                    `Post created for userId :${currentUser._id}`
                                );
                                return res.json({
                                    message: `Post created`,
                                    post: post,
                                });
                            })
                            .catch((err) => {
                                console.log(
                                    `Error occcured while creating post: ${err}`
                                );
                                logger.error(
                                    `Error occcured while creating post: ${err}`
                                );
                                return res.json({
                                    errorMessage: `Error occcured while creating post: ${err}`,
                                });
                            });
                    }
                })
                .catch((err) => {
                    console.log(
                        `Error in adding points for userId ${currentUser._id}`
                    );
                    logger.error(
                        `Error in adding points for userId ${currentUser._id}`
                    );
                    return res
                        .status(503)
                        .json({ errorMessage: `Unable to upadate points` });
                });
        })
        .catch((err) => {
            console.log(err);
            logger.error(err);
            return res.status(503).json({
                errorMessage: `Error in finding constant value of poiints for ${currentUser._id}`,
            });
        });
};

exports.likePost = (req, res, next) => {
    const currentUser = req.session.user;
    const postId = req.body.postId;
    postServices
        .ifLiked(currentUser._id, postId)
        .then((liked) => {
            console.log(liked);
            if (liked === true) {
                Post.findOneAndUpdate(
                    { _id: postId },
                    { $pull: { likes: { like: currentUser._id } } },
                    { new: true }
                )
                    .then((post) => {
                        return res.json({
                            post: post,
                            liked: false,
                            message: `Removed like for ${currentUser._id}`,
                        });
                    })
                    .catch((err) => {
                        console.log(
                            `Error in posting a like due for ${currentUser._id}`,
                            err
                        );
                        logger.error(
                            `Error in posting a like due for ${currentUser._id}`,
                            err
                        );
                        return res.json({
                            errorMessage: `Error in posting like : ${err} for ${currentUser._id}`,
                        });
                    });
            } else {
                Post.findOneAndUpdate(
                    { _id: postId },
                    {
                        $push: {
                            likes: { like: currentUser._id, time: Date.now() },
                        },
                    },
                    { new: true }
                )
                    .then((post) => {
                        Constants.findOne({ name: "points" })
                            .select("value")
                            .then((pointSet) => {
                                let likevalue = pointSet.value.like;
                                let pointPromise = userServices.addPoints(
                                    currentUser._id,
                                    likevalue
                                );
                                pointPromise
                                    .then((result) => {
                                        return res.json({
                                            post: post,
                                            liked: true,
                                        });
                                    })
                                    .catch((err) => {
                                        logger.error(
                                            `Error in updating points in point promise for likes : ${err}`
                                        );
                                        console.log(
                                            `Error in updating points in point promise for likes : ${err}`
                                        );
                                        return res.json({
                                            errorMessage: `Error in updating points in point promise for likes : ${err}`,
                                        });
                                    });
                            });
                    })
                    .catch((err) => {
                        console.log(
                            `Error in posting a like due for ${currentUser._id}`,
                            err
                        );
                        logger.error(
                            `Error in posting a like due for ${currentUser._id}`,
                            err
                        );
                        return res.json({
                            errorMessage: `Error in posting like : ${err} for ${currentUser._id}`,
                        });
                    });
            }
        })
        .catch((err) => {
            console.log(`Error in finding ifLiked for ${currentUser._id}`);
            logger.error(`Error in finding ifLiked for ${currentUser._id}`);
        });
};

exports.getPost = (req, res, next) => {
    const currentUser = req.session.user;
    const postId = req.params.postId;
    let liked = false;
    postServices
        .ifLiked(currentUser._id, postId)
        .then((result) => {
            liked = result;
            Post.findOne({ _id: postId })
                .populate(
                    "userId",
                    "local.username google.name linkedin.name facebook.name twitter.name imageUrl"
                )
                .then((result) => {
                    return res.json({ post: result, liked: liked });
                })
                .catch((err) => {
                    console.log(err);
                    logger.error(
                        `Error in finding the post with postId :${postId} for ${currentUser._id}`
                    );
                    return res.json({
                        errorMessage: `Error in finding the post with postId :${postId} for ${currentUser._id}`,
                    });
                });
        })
        .catch((err) => {
            console.log(err);
            return res.json(err);
        });
};

exports.getTickerSuggestions = (req, res, next) => {
    const keyword = req.body.keyword;
    const currentUser = req.session.user;
    logger.info(`Getting tickers for suggestion word ${keyword}`);
    Ticker.aggregate([
        {
            $match: {
                $or: [
                    {
                        symbol: {
                            $regex: keyword,
                            $options: "i",
                        },
                    },
                    {
                        value: {
                            $regex: keyword,
                            $options: "i",
                        },
                    },
                ],
            },
        },
    ])
        .then((result) => {
            var uniqueDocs = result.reduce((unique, o) => {
                if (!unique.some((obj) => obj._id === o._id)) {
                    unique.push(o);
                }
                return unique;
            }, []);
            return res.json(uniqueDocs);
        })
        .catch((err) => {
            console.log(err);
            logger.error(
                `Error in getting ticekr suggestions for ${currentUser._id}`
            );
        });
};

exports.allTickers = (req, res, next) => {
    Ticker.find()
        .then((result) => {
            return res.json(result);
        })
        .catch((err) => {
            logger.error(`Error occured while fetching tickers`);
        });
};

//comment logic

exports.postComment = (req, res, next) => {
    var comment = {};
    const currentUser = req.session.user;
    comment.comment = req.body.comment;
    comment.postedBy = currentUser._id;
    //console.log(comment);
    Comment.findOneAndUpdate(
        { postId: req.body.postId },
        { $push: { comments: comment } },
        { new: true }
    )
        .populate("comments.postedBy postId")
        .exec((err, result) => {
            if (err) {
                logger.error(
                    "Error in updating request document in mongo",
                    err
                );
                return res.status(400).json({ error: err });
            } else {
                const requester = result.postId;
                if (
                    requester.userId.toString() !== currentUser._id.toString()
                ) {
                    var payload = {
                        title: "GO REFER NOTIFICATION",
                        body: `You have a new comment on your post by ${currentUser.name}. Click to see`,
                    };
                    console.log(
                        `${currentUser._id} is trying to comment on ${result.postId._id}'s post`
                    );
                    //     var promise = userServices.userExists(requester.userId);
                    //     promise.then((results) => {

                    //         //firebase notification service//

                    //         // firebaseService.sendPushNotif(
                    //         //     results[0].firebaseToken,
                    //         //     payload
                    //         // );

                    //         //notification done
                    //     });
                }
                var newComments = result.comments;
                //console.log(newComments);
                console.log(
                    `${currentUser._id} tried to post a comment for ${req.body.postId}`
                );
                Constants.findOne({ name: "points" })
                    .select("value")
                    .then((pointSet) => {
                        let commentvalue = pointSet.value.comment;
                        let pointPromise = userServices.addPoints(
                            currentUser._id,
                            commentvalue
                        );
                        pointPromise.then((result) => {
                            res.json({
                                comments: newComments,
                                posttDoc: result.postId,
                            }).catch((err) => {
                                logger.error(
                                    `Error in updating points in point promise for comments : ${err}`
                                );
                                console.log(
                                    `Error in updating points in point promise for comments : ${err}`
                                );
                                return res.json({
                                    errorMessage: `Error in updating points in point promise for comments : ${err}`,
                                });
                            });
                        });
                    });
            }
        });
};

exports.postDelComment = (req, res, next) => {
    var comment = req.body.comment;
    Comment.findOneAndUpdate(
        { comments: { $elemMatch: { _id: comment._id } } },
        { $set: { "comments.$.markDel": true } }
    )
        .then((results) => {
            res.json({
                message: "Comment marked for deletion but not removed",
            });
        })
        .catch((err) => {
            console.log(err);
        });
};

exports.getReqComments = (req, res, next) => {
    const postId = req.params.postId;
    const currentUser = req.session.user;
    var comments = [];
    console.log(
        `${currentUser._id} tried to access the comments for ${postId}`
    );
    Comment.findOne({ postId: postId })
        .populate("comments.postedBy")
        .then(async (results) => {
            console.log(results);
            if (results) {
                comments = results.comments.filter((comment) => {
                    return comment.markDel === false;
                });
                comments.map((comment) => {
                    if (comment.postedBy.imageUrl === undefined) {
                        comment.postedBy.imageUrl = "";
                    }
                    return comment;
                });
            } else {
                comments = [];
            }

            await Post.findOne({
                _id: postId,
            }).then((post) => {
                if (post) {
                    res.json({
                        comments: comments,
                        postDoc: post,
                    });
                } else {
                    logger.error(
                        "Request not found for the corresponding postId",
                        postId
                    );
                    res.json([]);
                }
            });
        })
        .catch((err) => {
            logger.error("Comments not found for the specific postId", err);
            return res.status(404).json({ message: "Comments not found" });
        });
};

exports.dailytrendingPosts = (req, res, next) => {
    const today = new Date();
    const yesterday = new Date();
    yesterday.setHours(today.getHours() - 24);

    let trendinPromise = postServices.trendingService(yesterday, today);
    trendinPromise
        .then(async (result) => {
            return res.json(result);
        })
        .catch((err) => {
            logger.error(`Error in finding trending topics : ${err}`);
            console.log(`Error in finding trending topics : ${err}`);
        });
};

exports.getFeed = (req, res, next) => {
    let endTimestamp = new Date();
    let currentUser = req.session.user;
    let hourly = Boolean(req.query.hourly);
    let weekly = Boolean(req.query.weekly);
    let startTimestamp = new Date();
    console.log(typeof hourly);
    if (hourly === true) {
        startTimestamp.setHours(endTimestamp.getHours() - 24);
    } else if (weekly === true) {
        startTimestamp.setHours(endTimestamp.getHours() - 24 * 7);
    } else {
        startTimestamp = new Date(req.query.startTimestamp);

        if (req.query.endTimestamp !== undefined) {
            endTimestamp = new Date(req.query.endTimestamp);
        }
    }

    let feedPromise = postServices.feedService(
        startTimestamp,
        endTimestamp,
        currentUser._id
    );
    feedPromise.then((result) => {
        return res.json(result);
    });
};

exports.getUserPosts = (req, res, next) => {
    const limit = 20;
    const page = req.query.page;
    const startIndex = (page - 1) * limit;
    const endIndex = page * limit;
    const currentUser = req.session.user;
    const checkUser = req.params.checkUser;
    async.parallel(
        [
            function (outercallback) {
                Post.aggregate([
                    {
                        $match: {
                            userId: ObjectId(checkUser),
                        },
                    },
                    {
                        $lookup: {
                            from: "comments",
                            localField: "_id",
                            foreignField: "postId",
                            as: "comments",
                        },
                    },
                    { $unwind: "$comments" },
                    {
                        $lookup: {
                            from: "reposts",
                            localField: "_id",
                            foreignField: "repostFrom",
                            as: "reposts",
                        },
                    },
                    { $sort: { createdAt: -1 } },
                ]).then(async (results) => {
                    //console.log(results);
                    const filteredFollowing = [];
                    async.forEach(
                        results,
                        (result, callback) => {
                            let likedPromise = postServices.ifLiked(
                                currentUser._id,
                                result._id
                            );
                            likedPromise
                                .then((liked) => {
                                    result.liked = liked;
                                    filteredFollowing.push(result);
                                    callback();
                                    // if (
                                    //     result.userId.toString() ===
                                    //     currentUserId.toString()
                                    // ) {
                                    //     //console.log(result);
                                    //     filteredFollowing.push(result);
                                    //     callback();
                                    // } else {
                                    //     Follow.findOne({
                                    //         userId: currentUserId,
                                    //         following: result.userId,
                                    //     }).then((foundFollower) => {
                                    //         if (foundFollower) {
                                    //             // console.log(foundFollower);
                                    //             filteredFollowing.push(
                                    //                 result
                                    //             );
                                    //             return callback();
                                    //         } else {
                                    //             return callback();
                                    //         }
                                    //     });
                                    // }
                                })
                                .catch((err) => {
                                    logger.error(
                                        `Error occured in fetching like for ${currentUserId}`
                                    );
                                    console.log(
                                        `Error occured in fetching like for ${currentUserId}`
                                    );
                                    return res.json(err);
                                });
                        },
                        (err) => {
                            if (err) {
                                console.log(err);
                                logger.error(err);
                                return res.json({ errorMessage: err });
                            }
                            console.log(`Post Iterating done`);
                            console.log(filteredFollowing.length);
                            if (filteredFollowing.length > 0) {
                                outercallback(null, filteredFollowing);
                            } else {
                                outercallback([]);
                            }
                        }
                    );
                });
            },
            function (outercallback) {
                Repost.aggregate([
                    {
                        $match: {
                            userId: ObjectId(checkUser),
                        },
                    },
                    {
                        $lookup: {
                            from: "comments",
                            localField: "_id",
                            foreignField: "postId",
                            as: "comments",
                        },
                    },
                    { $unwind: "$comments" },
                    { $sort: { createdAt: -1 } },
                ]).then(async (results) => {
                    //console.log(results);
                    const filteredFollowing = [];
                    async.forEach(
                        results,
                        (result, callback) => {
                            //console.log(result);
                            let likedPromise = postServices.ifRepostLiked(
                                currentUser._id,
                                result._id
                            );
                            likedPromise
                                .then((liked) => {
                                    result.liked = liked;
                                    filteredFollowing.push(result);
                                    callback();
                                    // if (
                                    //     result.userId.toString() ===
                                    //     currentUserId.toString()
                                    // ) {
                                    //     //console.log(result);
                                    //     filteredFollowing.push(result);
                                    //     callback();
                                    // } else {
                                    //     Follow.findOne({
                                    //         userId: currentUserId,
                                    //         following: result.userId,
                                    //     }).then((foundFollower) => {
                                    //         if (foundFollower) {
                                    //             // console.log(foundFollower);
                                    //             filteredFollowing.push(
                                    //                 result
                                    //             );
                                    //             return callback();
                                    //         } else {
                                    //             return callback();
                                    //         }
                                    //     });
                                    // }
                                })
                                .catch((err) => {
                                    logger.error(
                                        `Error occured in fetching like for ${currentUserId}`
                                    );
                                    console.log(
                                        `Error occured in fetching like for ${currentUserId}`
                                    );
                                    return res.json({ errorMessage: err });
                                });
                        },
                        (err) => {
                            if (err) {
                                console.log(err);
                                logger.error(err);
                                return res.json({ errorMessage: err });
                            }
                            console.log(`Repost Iterating done`);
                            console.log(filteredFollowing);
                            if (filteredFollowing.length > 0) {
                                outercallback(null, filteredFollowing);
                            } else {
                                outercallback([]);
                            }
                        }
                    );
                });
            },
        ],
        (err, result) => {
            const results = [].concat
                .apply([], result)
                .slice()
                .sort((a, b) => b.createdAt - a.createdAt);
            console.log(results.length);
            let userDetails = userServices.getUserDetails(checkUser);
            userDetails
                .then((user) => {
                    if (user) {
                        return res.json({
                            content: results.splice(startIndex, endIndex),
                            userDetails: user,
                        });
                    } else {
                        return res.json({
                            content: results.splice(startIndex, endIndex),
                        });
                    }
                })
                .catch((err) => {
                    console.log(
                        `Error occured in finding userdetails : ${err}`
                    );
                    logger.error(
                        `Error occured in finding userdetails : ${err}`
                    );
                });
        }
    );
};
