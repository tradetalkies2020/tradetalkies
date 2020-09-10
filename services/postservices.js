const User = require("../models/User");
const Constant = require("../models/constants");
const Post = require("../models/Post");
const { ProcessCredentials } = require("aws-sdk");

exports.ifLiked = (userId, postId) => {
    return new Promise((resolve, reject) => {
        Post.findOne({ _id: postId, "likes.like":userId })
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
