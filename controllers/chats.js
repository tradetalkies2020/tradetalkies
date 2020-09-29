const logger = require("../middleware/logger");
const dbService = require("../services/chatDBservice");
const userServices = require("../services/userservices");
const Chat = require("../models/Chat");
const Constants = require("../models/constants");
const Message = require("../models/Message");
const User = require("../models/User");
exports.postMessages = async (req, res, next) => {
    var userid = req.session.user._id;
    var chatId = req.body.chatId;
    var createdAt = new Date(Date.now());
    let images=[];
    if (req.files !== undefined) {
        await req.files.forEach((file) => {
            images.push(file.location);
        });
    } else if (req.file !== undefined) {
        images.push(req.file.location);
    }
    logger.info("/chat/message post route ", chatId);
    var promise = dbService.postMessage(
        chatId,
        req.body.message,
        images,
        userid,
        createdAt
    );
    promise
        .then((result) => {
            logger.info("chat route: posted message: " + chatId);
            res.json(result);
        })
        .catch((err) => {
            logger.error(
                "chat route: Error posting message: " +
                    chatId +
                    " err: " +
                    JSON.stringify(err)
            );
            return next(err);
        });
};

exports.getChatList = (req, res, next) => {
    console.log(req.user._id);
    var userid = req.session.user._id;
    var page = req.query.page;
    logger.info(
        "/chat/chatList route fbId: " +
            userid +
            " page: " +
            req.query.page +
            " lastId: " +
            req.query.lastId
    );
    if (typeof page === "undefined" || page === null) {
        page = 0;
    }

    var promise = dbService.getChatList(userid, page, req.query.lastId);
    promise
        .then((chatList) => {
            console.log(chatList);
            logger.info(
                "chat route: Got chats for fbId: " + userid + " page: " + page
            );
            res.json(chatList);
        })
        .catch((err) => {
            logger.error(
                "chat route: Error getting chats for fbId: " +
                    userid +
                    "page: " +
                    page +
                    " err: " +
                    JSON.stringify(err)
            );
            return next(err);
        });
};

exports.getMessages = (req, res, next) => {
    const chatId = req.params.chatId;
    const currentUser = req.session.user;
    Chat.findOne({ _id: chatId }).then(async (chat) => {
        var chatUsers = chat.users.map((user) => {
            return user["userid"];
        });
        if (chatUsers.includes(req.session.user._id)) {
            await Message.aggregate([
                { $match: { chatId: chat._id } },
                {
                    $lookup: {
                        from: "users",
                        localField: "userid",
                        foreignField: "_id",
                        as: "user",
                    },
                },
                {
                    $unwind: "$user",
                },
                { $unwind: "$messages" },
                {
                    $project: {
                        "user.age": 0,
                        "user.createdAt": 0,
                        "user.industry": 0,
                        "user.refCode": 0,
                        "user.points": 0,
                        "user.referred": 0,
                    },
                },
            ]).then(async (messages) => {
                var userMessages = [],
                    peoplemessages = [];
                messages.forEach((messageDoc) => {
                    if (
                        messageDoc.userid.toString() ===
                        currentUser._id.toString()
                    ) {
                        userMessages.push(messageDoc);
                    } else {
                        peoplemessages.push(messageDoc);
                    }
                });
                await Chat.findOneAndUpdate(
                    { _id: chatId, "users.userid": currentUser._id },
                    { $set: { "users.$.unread": 0 } }
                )
                    .then((results) => {
                        res.json({ userMessages, peoplemessages });
                    })
                    .catch((err) => {
                        logger.error("Error in updating unread : ", err);
                    });
            });
        } else {
            res.status(422).json({
                message:
                    "You don't get to read chats that aren't meant for you.",
            });
        }
    });
};

exports.createChat = (req, res, next) => {
    const currentUser = req.session.user;
    const userToText = req.body.userToText;
    const message = req.body.message;
    let followerPromise = userServices.getUserFollowers(currentUser._id);
    followerPromise
        .then((followers) => {
            if (followers.includes(userToText)) {
                let chatExists = dbService.chatExists(
                    currentUser._id,
                    userToText
                );
                chatExists
                    .then((chatData) => {
    if (chatData) {
    return res.json({
    message: `Chat already exists between ${currentUser._id} and ${userToText}`,
    });
    } else {
    User.findOne({ _id: userToText })
    .then((recievinguser) => {
    if (!recievinguser) {
    return res.json({
        errorMessage: `No user found by the id : ${userToText}`,
    });
    } else {
    let createChatInstance = dbService.createChat(
        currentUser,
        recievinguser,
        message
    );
    createChatInstance
        .then((result) => {
            Constants.findOne({
                name: "points",
            })
                .select("value")
                .then((pointset) => {
                    let groupCreationValue =
                        pointset.value
                            .creategroup;

                    //add points of group creation before sending response.
                    let pointsInstance = userServices.addPoints(
                        currentUser._id,
                        groupCreationValue
                    );
                    pointsInstance.then(
                        (done) => {
                            return res.json(
                                {
                                    message: `Chat created with chat Id : ${result}`,
                                }
                            );
                        }
                    );
                });
        })
        .catch((err) => {
            console.log(err);
            logger.error(
                `Error in creating chat : ${err}`
            );
            return res.json({
                errorMessage: `Error in creating chst instance.`,
            });
        });
    }
                                })
                                .catch((err) => {
                                    //error in finding user
                                    logger.error(
                                        `Error in finding by the _id : ${userToText}`
                                    );
                                });
                        }
                    })
                    .catch((err) => {
                        console.log(err);
                        logger.error(`Error in finding chat Id : ${err}`);
                        return res.json({
                            errorMessage: `Error in finding chat`,
                        });
                    });
            }
        })
        .catch((err) => {
            console.log(err);
            logger.error(
                `Error in finding followers for userId : ${currentUser._id}`
            );
            return res.json({
                errorMessage: `Error in finding followers for user Id : ${currentUser._id}`,
            });
        });
};
