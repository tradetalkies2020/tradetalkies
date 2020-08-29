const Post = require("../models/Post");
const User = require("../models/User");
const Comment = require("../models/comment");
const Ticker = require("../models/Tickers");
const Constants = require("../models/constants");
const userServices = require("../services/userservices");
const postServices = require("../services/postservices");
const logger = require("../middleware/logger");
const Tickers = require("../models/Tickers");

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
                                console.log(
                                    `Post created for userId :${currentUser._id}`
                                );
                                logger.info(
                                    `Post created for userId :${currentUser._id}`
                                );
                                return res.json({
                                    messgae: `Post created`,
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
    Post.findOneAndUpdate(
        { _id: postId },
        { $push: { likes: currentUser._id } },
        { new: true }
    )
        .then((post) => {})
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
