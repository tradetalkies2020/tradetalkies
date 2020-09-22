const User = require("../models/User");
const Constant = require("../models/constants");
const Post = require("../models/Post");
const mongoose = require("mongoose");
const Follow = require("../models/Follow");
const async = require("async");
exports.ifLiked = (userId, postId) => {
    return new Promise((resolve, reject) => {
        Post.findOne({ _id: postId, "likes.like": userId })
            .then((result) => {
                if (!result) {
                    return resolve(false);
                } else {
                    return resolve(true);
                }
            })
            .catch((err) => {
                console.log(err);
                logger.error(err);
                return reject(err);
            });
    });
};

exports.trendingService = (startTimeStamp, endTimeStamp) => {
    console.log(startTimeStamp, endTimeStamp);
    return new Promise((resolve, reject) => {
        Post.aggregate([
            // { $match: { "likes.time": { $gte: yesterday } } },

            //stage for looking up comments for each post
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
                $project: {
                    _id: 1,
                    desc: 1,
                    tickers: 1,
                    userId: 1,
                    images: 1,
                    comments: {
                        $filter: {
                            input: "$comments.comments",
                            as: "el",
                            cond: {
                                $and: [
                                    {
                                        $lte: ["$$el.createdAt", endTimeStamp],
                                    },
                                    {
                                        $eq: ["$$el.markDel", false],
                                    },
                                ],
                            },
                        },
                    },
                    liked: {
                        $filter: {
                            input: "$likes",
                            as: "item",
                            cond: {
                                $and: [
                                    { $gte: ["$$item.time", startTimeStamp] },
                                    { $lte: ["$$item.time", endTimeStamp] },
                                ],
                            },
                        },
                    },
                },
            },
            {
                $lookup: {
                    from: "users",
                    localField: "userId",
                    foreignField: "_id",
                    as: "userDetails",
                },
            },
            { $unwind: "$userDetails" },
            {
                $lookup: {
                    from: "reposts",
                    localField: "_id",
                    foreignField: "repostFrom",
                    as: "repost",
                },
            },

            {
                $match: {
                    $or: [
                        { "liked.0": { $exists: true } },
                        { "comments.0": { $exists: true } },
                    ],
                },
            },
            {
                $project: {
                    reposted: {
                        $filter: {
                            input: "$repost",
                            as: "item",
                            cond: {
                                $and: [
                                    {
                                        $gte: [
                                            "$$item.createdAt",
                                            startTimeStamp,
                                        ],
                                    },
                                    {
                                        $lte: [
                                            "$$item.createdAt",
                                            endTimeStamp,
                                        ],
                                    },
                                ],
                            },
                        },
                    },
                    _id: 1,
                    userDetails: 1,
                    desc: 1,
                    tickers: 1,
                    images: 1,
                    liked: 1,
                    comments: 1,
                },
            },
        ])
            .then((results) => {
                results.forEach((result) => {
                    let likelength = result.liked.length;
                    let commentLength = result.comments.length;
                    let repostLength = result.reposted.length;
                    result.z_score = likelength + commentLength + repostLength;
                });
                results.sort(function (a, b) {
                    return b.z_score - a.z_score;
                });

                return resolve(results);
            })
            .catch((err) => {
                console.log(err);
                logger.error(`Error in trending serviecs : ${err}`);
                reject(err);
            });
    });
};

exports.feedService = (startTimestamp, endTimestamp, currentUserId) => {
    console.log(startTimestamp, endTimestamp);
    return new Promise((resolve, reject) => {
        Post.aggregate([
            {
                $match: {
                    createdAt: { $gte: startTimestamp, $lte: endTimestamp },
                },
            },
            {
                $lookup: {
                    from: "users",
                    localField: "userId",
                    foreignField: "_id",
                    as: "userDetails",
                },
            },
            { $unwind: "$userDetails" },
            { $sort: { createdAt: -1 } },
        ]).then(async (results) => {
            console.log(results.length);
            const filteredFollowing = [];
            async.forEach(
                results,
                (result, callback) => {
                    let likedPromise = this.ifLiked(currentUserId, result._id);
                    likedPromise
                        .then((liked) => {
                            result.liked = liked;
                            if (
                                result.userId.toString() ===
                                currentUserId.toString()
                            ) {
                                console.log(result);
                                filteredFollowing.push(result);
                                callback();
                            } else {
                                Follow.findOne({
                                    userId: currentUserId,
                                    following: result.userId,
                                }).then((foundFollower) => {
                                    if (foundFollower) {
                                        // console.log(foundFollower);
                                        filteredFollowing.push(result);
                                        return callback();
                                    } else {
                                        return callback();
                                    }
                                });
                            }
                        })
                        .catch((err) => {
                            logger.error(
                                `Error occured in fetching like for ${currentUserId}`
                            );
                            console.log(
                                `Error occured in fetching like for ${currentUserId}`
                            );
                            reject(err);
                        });
                },
                (err) => {
                    if (err) {
                        console.log(err);
                        logger.error(err);
                        reject(err);
                    }
                    console.log(`Iterating done`);
                    //console.log(filteredFollowing);
                    console.log(filteredFollowing.length);
                    return resolve(filteredFollowing);
                }
            );
        });
    });
};
