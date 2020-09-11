const Post = require("../models/Post");
const User = require("../models/User");
const Comment = require("../models/comment");
const Ticker = require("../models/Tickers");
const Constants = require("../models/constants");
const userServices = require("../services/userservices");
const postServices = require("../services/postservices");
const logger = require("../middleware/logger");
const Tickers = require("../models/Tickers");
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
                        return res.json({ post: post, liked: true });
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
                        `${currentUser.name} is trying to comment on ${result.postId._id}'s post`
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
                res.json({ comments: newComments, posttDoc: result.postId });
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

exports.trendingPosts = (req, res, next) => {
    const now = new Date();
    const yesterday = new Date();
    yesterday.setHours(now.getHours() - 48);
    console.log(yesterday);
    Post.aggregate([
        { $match: { "likes.time": { $gte: yesterday } } },
        {
            $lookup: {
                from: "comments",
                localField: "_id",
                foreignField: "postId",
                as: "comments",
            },
        },
        {
            $project: {
                _id: 1,
                comments: 1,
                liked: {
                    $filter: {
                        input: "$likes",
                        as: "item",
                        cond: {
                            $and: [
                                { $gte: ["$$item.time", yesterday] },
                                { $lte: ["$$item.time", now] },
                            ],
                        },
                    },
                },
            },
        },
        // {
        //     $project: {
        //         _id: "$_id",
        //         liked: {
        //             $reduce: {
        //                 input: "$likes",
        //                 initialValue: "Bad",
        //                 in: {
        //                   $cond: [
        //                     {
        //                       $gte: [
        //                         "$$this.time",
        //                         yesterday
        //                       ]
        //                     },
        //                     "$$this",
        //                     "$$REMOVE"
        //                   ]
        //                 }
        //               }
        //             // $push: {
        //             //     $cond: [
        //             //         { $gte: ["$likes.time", yesterday] },
        //             //         { like: "$likes.like", time: "$likes.time" },
        //             //         "$$REMOVE",
        //             //     ],
        //             // },
        //         },
        //     },
        // },
    ]).then((result) => {
        return res.json(result);
    });
};
