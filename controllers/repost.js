const Post = require("../models/Post");
const Repost = require("../models/Repost");
const User = require("../models/User");
const Comment = require("../models/comment");
const Ticker = require("../models/Tickers");
const Constants = require("../models/constants");
const userServices = require("../services/userservices");
const postServices = require("../services/postservices");
const logger = require("../middleware/logger");

exports.postNewRepost = async (req, res, next) => {
    const currentUser = req.session.user;
    const tickers = req.body.tickers;
    const desc = req.body.desc;
    let images = [];
    const repostFrom = req.body.repostId;

    //image handler//
    if (req.files !== undefined) {
        await req.files.forEach((file) => {
            images.push(file.location);
        });
    } else if (req.file !== undefined) {
        images.push(req.file.location);
    }

    //end image handler//

    const repost = new Repost({
        userId: currentUser._id,
        tickers: tickers,
        desc: desc,
        likes: [],
        images: images,
        repostFrom: repostFrom,
    });
    console.log(repost);

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
                        repost
                            .save()
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
                                    message: `Repost created for postId : ${repostFrom}`,
                                    post: repost,
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

exports.likeRepost = (req, res, next) => {
    const currentUser = req.session.user;
    const repostId = req.body.repostId;
    postServices
        .ifLiked(currentUser._id, repostId)
        .then((liked) => {
            console.log(liked);
            if (liked === true) {
                Repost.findOneAndUpdate(
                    { _id: repostId },
                    { $pull: { likes: { like: currentUser._id } } }
                )
                    .then((repost) => {
                        return res.json({
                            repost: repost,
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
                Repost.findOneAndUpdate(
                    { _id: repostId },
                    {
                        $push: {
                            likes: { like: currentUser._id, time: Date.now() },
                        },
                    },
                    { new: true }
                )
                    .then((repost) => {
                        return res.json({ repost: repost, liked: true });
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
