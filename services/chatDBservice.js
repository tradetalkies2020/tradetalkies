var mongoose = require("mongoose");
var chat = require("../models/Chat");
const Message = require("../models/Message");
const User = require("../models/User");
const logger = require("../middleware/logger");
var async = require("async");
//   var config = require("../config");
// var emailService = require("./emailService.js");
var firebaseService = require("./firebaseDBService");
// var reportService = require("./reportService.js");
// var notification = require("../models/notif");
// var fs = require("fs");
var _ = require("lodash");

exports.postMessage = (chatId, message, userUId, createdAt) => {
    logger.info(
        "chatDBService.postMessage: posting a message " +
            message +
            " for chatId: " +
            chatId +
            " UID: " +
            userUId
    );

    if (createdAt == undefined || createdAt == null) {
        createdAt = new Date();
    }

    return new Promise((resolve, reject) => {
        chat.findOne({ _id: chatId })
            .populate("users.userid", "userid name imageUrl firebaseToken")
            .exec((err, result) => {
                const usersInChat = result.users.map((user) => {
                    return user.userid._id;
                });

                if (err) {
                    logger.error(
                        "chatDbService.postMessage: Error finding a chat! with chatId: " +
                            chatId +
                            JSON.stringify(err)
                    );
                    return reject(err);
                }

                if (result != null && usersInChat.includes(userUId)) {
                    async.parallel(
                        [
                            (callback) => {
                                // result.messages.push({message: message, createdAt: createdAt, userid: userUId, });
                                result.lastMessage = message;
                                result.lastTimestamp = createdAt;

                                Message.findOneAndUpdate(
                                    { userid: userUId, chatId: chatId },
                                    {
                                        $push: {
                                            messages: {
                                                message: message,
                                                createdAt: createdAt,
                                            },
                                        },
                                    },
                                    (err, messageDoc) => {
                                        if (err) {
                                            logger.error(
                                                "Error in updating the message collection",
                                                err
                                            );
                                        }

                                        if (messageDoc === null) {
                                            new Message({
                                                messages: [
                                                    {
                                                        message: message,
                                                        createdAt: createdAt,
                                                    },
                                                ],
                                                userid: userUId,
                                                chatId: chatId,
                                            }).save((err, messageOut) => {
                                                if (err) {
                                                    logger.error(
                                                        "chatDBService.postmessage: Error posting a message for chatId: " +
                                                            chatId +
                                                            " err: " +
                                                            JSON.stringify(err)
                                                    );
                                                    return callback(err);
                                                }
                                                messageDoc = messageOut;
                                                var index = 0;
                                                result.users.forEach((user) => {
                                                    // increment the unread count of other user.
                                                    if (
                                                        user.userid._id.toString() !==
                                                        userUId.toString()
                                                    ) {
                                                        var existingUnread =
                                                            result.users[index]
                                                                .unread;
                                                        result.users[
                                                            index
                                                        ].unread = ++existingUnread;
                                                    } else {
                                                        result.users[
                                                            index
                                                        ].unread = 0;
                                                    }
                                                    ++index;
                                                });

                                                result.save((errSave, chat) => {
                                                    if (errSave) {
                                                        logger.error(
                                                            "chatDBService.postmessage: Error posting a message for chatId: " +
                                                                chatId +
                                                                " err: " +
                                                                JSON.stringify(
                                                                    errSave
                                                                )
                                                        );
                                                        return callback(
                                                            errSave
                                                        );
                                                    }
                                                });
                                                console.log(
                                                    "Found message:",
                                                    messageDoc
                                                );
                                            });
                                            return callback();
                                        } else {
                                            var index = 0;
                                            result.users.forEach((user) => {
                                                console.log(user);
                                                // increment the unread count of other user.
                                                if (
                                                    user.userid._id.toString() !==
                                                    userUId.toString()
                                                ) {
                                                    var existingUnread =
                                                        result.users[index]
                                                            .unread;
                                                    result.users[
                                                        index
                                                    ].unread = ++existingUnread;
                                                    console.log(
                                                        "Unread function : ",
                                                        result.users[index]
                                                            .unread
                                                    );
                                                } else {
                                                    result.users[
                                                        index
                                                    ].unread = 0;
                                                }
                                                ++index;
                                            });

                                            result.save((errSave, chat) => {
                                                if (errSave) {
                                                    logger.error(
                                                        "chatDBService.postmessage: Error posting a message for chatId: " +
                                                            chatId +
                                                            " err: " +
                                                            JSON.stringify(
                                                                errSave
                                                            )
                                                    );
                                                    return callback(errSave);
                                                }

                                                return callback();
                                            });
                                        }
                                    }
                                );
                            },
                            (callback) => {
                                // send a firebase notification
                                var dataJson = {};
                                var firebaseToken;
                                var userDetails = result.users;
                                var myData = {};
                                var userData = {};
                                myData = User.findOne({ _id: userUId }).then(
                                    (user) => {
                                        return user;
                                    }
                                );

                                myData
                                    .then((_myData) => {
                                        async.forEach(
                                            userDetails,
                                            (userDetail, callbacke) => {
                                                if (
                                                    userDetail.userid._id.toString() !==
                                                    userUId.toString()
                                                ) {
                                                    userData = User.findOne({
                                                        _id:
                                                            userDetail.userid
                                                                ._id,
                                                    }).then((user) => {
                                                        return user;
                                                    });

                                                    userData
                                                        .then((_userData) => {
                                                            firebaseToken =
                                                                _userData.firebaseToken;
                                                            console.log(
                                                                _userData
                                                            );

                                                            async.waterfall(
                                                                [
                                                                    (
                                                                        innerCallback
                                                                    ) => {
                                                                        if (
                                                                            _myData.imageUrl !=
                                                                            null
                                                                        ) {
                                                                            try {
                                                                                myData.imageUrl =
                                                                                    _myData.imageUrl;
                                                                                innerCallback();
                                                                            } catch (e) {
                                                                                logger.error(
                                                                                    "Error in finding imageUrl for current user"
                                                                                );
                                                                            }
                                                                        } else {
                                                                            return innerCallback();
                                                                        }
                                                                    },
                                                                    (
                                                                        innerCallback
                                                                    ) => {
                                                                        dataJson.title =
                                                                            "GO_REFER";
                                                                        dataJson.firebaseToken =
                                                                            _myData.firebaseToken;
                                                                        dataJson.body = message;
                                                                        dataJson.chatId = chatId;
                                                                        dataJson.userid = userUId;
                                                                        dataJson.name =
                                                                            _myData.name;
                                                                        dataJson.imageUrl =
                                                                            _myData.imageUrl;
                                                                        dataJson.icon =
                                                                            "";
                                                                        dataJson.action =
                                                                            "";
                                                                        dataJson.createdAt = createdAt.toString();
                                                                        console.log(
                                                                            dataJson,
                                                                            firebaseToken
                                                                        );
                                                                        firebaseService.sendNotification(
                                                                            firebaseToken,
                                                                            dataJson,
                                                                            "chatting"
                                                                        );
                                                                        return innerCallback();
                                                                    },
                                                                ],
                                                                (
                                                                    err,
                                                                    results
                                                                ) => {
                                                                    if (err) {
                                                                        logger.error(
                                                                            "chatDbService.postMessage: Error in async waterfall sending notif: " +
                                                                                userUId +
                                                                                JSON.stringify(
                                                                                    err
                                                                                )
                                                                        );
                                                                    }
                                                                    return callbacke();
                                                                }
                                                            );
                                                        })
                                                        .catch((err) => {
                                                            logger.error(
                                                                "Error in finding user data : ",
                                                                err
                                                            );
                                                            return callbacke();
                                                        });
                                                } else {
                                                    return callbacke();
                                                }
                                            },
                                            (err) => {
                                                return callback();
                                            }
                                        );
                                    })
                                    .catch((err) => {
                                        logger.error(
                                            "Error in finding personal data : ",
                                            err
                                        );
                                        return callback(err);
                                    });
                            },
                        ],
                        (err, result) => {
                            if (err) {
                                logger.error(
                                    "chatDbService.postMessage: Error parallel: " +
                                        chatId +
                                        JSON.stringify(err)
                                );
                                return reject(err);
                            }

                            var status = { status: "Success",createdAt:createdAt };
                            console.log(status);
                            return resolve(status);
                        }
                    );
                } else {
                    // if no chat found.
                    logger.error(
                        "Error adding messages to chat: No such chat found! or user not in chat"
                    );
                    return reject(
                        "Error adding messages to chat: No such chat found! or user not in chat"
                    );
                    
                }
            });
    });
};

exports.getChatList = (userid, page, lastTimestamp) => {
    logger.info(
        "chatDBService.getChatList: finding chats for fbId: " +
            userid +
            " page: " +
            page +
            " lasttimestamp: " +
            lastTimestamp
    );
    var noOfItems = 10;
    if (lastTimestamp == null) {
        lastTimestamp = new Date();
    }
    console.log(lastTimestamp);
    page = parseInt(page);
    var match;
    if (page > 0) {
        match = {
            users: { $in: userid },
            unmatched: false,
            deActivated: { $ne: true },
        };
    } else {
        logger.info(
            "chatDBService.getChatList: page < 0! fbId: " +
                userid +
                " lastTimestamp to search for: " +
                lastTimestamp
        );
        match = {
            lastTimestamp: { $gt: lastTimestamp },
            users: { $in: userid },
            unmatched: false,
            deActivated: { $ne: true },
        };
        page *= -1; // abs
    }
    return new Promise((resolve, reject) => {
        // chat.find({users:{$elemMatch:{userid:userid}}}).then(allrecs=>
        //     {
        //       console.log(allrecs);
        //     })
        chat.find({ users: { $elemMatch: { userid: userid } } })
            .select(
                "lastMessage lastTimestamp unmatched deActivated users createdAt _id"
            )
            .populate("users.userid", "_id name imageUrl firebaseToken isAdmin")
            .sort({ lastTimestamp: -1 })
            .skip((page - 1) * noOfItems)
            .limit(noOfItems)
            .exec((err, results) => {
                // console.log(results);//Okay till here
                if (err) {
                    logger.error(
                        "chatDBService.getChatList: Error getting chats: " +
                            userid +
                            " page: " +
                            page +
                            " lastTimestamp: " +
                            lastTimestamp +
                            " err: " +
                            JSON.stringify(err)
                    );
                    return reject(err);
                }
                // for each record of chat in results
                async.eachOf(
                    results,
                    function (record, index, callback) {
                        // console.log(record);//okay till here
                        if (record.users != null) {
                            var users = record.users;
                            // TODO: improvise it by getting imageURL only for other user, not for myself.
                            async.eachOf(
                                users,
                                function (userDetail, userIndex, userCallback) {
                                    // console.log(userDetail);
                                    if (userDetail.userid === userid) {
                                        return userCallback();
                                    } else {
                                        if (userDetail.isAdmin === true) {
                                            results[index].users[
                                                userIndex
                                            ].name = "constants.NIKS";
                                        }
                                        if (userDetail.imageUrl != null) {
                                            try {
                                                results[index].userDetails[
                                                    userIndex
                                                ].imageUrl =
                                                    userDetail.imageUrl;
                                                return userCallback();
                                            } catch (err) {
                                                {
                                                    logger.error(
                                                        "chatDBService.getChatList: Error getting signed image url: " +
                                                            userid +
                                                            JSON.stringify(err)
                                                    );
                                                    return userCallback(err);
                                                }
                                            }
                                        } else {
                                            return userCallback();
                                        }
                                    }
                                },
                                (err) => {
                                    if (err) {
                                        logger.error(
                                            "chatDBService.getChatList: Error getting image s3 url fbId: " +
                                                userid +
                                                JSON.stringify(err)
                                        );
                                        return callback(err);
                                    }
                                    return callback();
                                }
                            );
                        } else {
                            return callback();
                        }
                    },
                    (err) => {
                        if (err) {
                            logger.error(
                                "chatDBService.getChatList: Error getting image s3 url fbId: " +
                                    userid +
                                    JSON.stringify(err)
                            );
                            return reject(err);
                        } else {
                            console.log(results);
                            return resolve(results);
                        }
                    }
                );
            });
    });
};
exports.getMessages = (chatId, page, lastId) => {
    logger.debug(
        "chatDBService.getChatMessages: finding all messages for chatId: " +
            chatId +
            " page: " +
            page +
            " lastId: " +
            lastId
    );
    var noOfItems = 30;
    page = parseInt(page);
    var condition;
    var match;
    chatId = mongoose.Types.ObjectId(chatId);
    return new Promise((resolve, reject) => {
        if (lastId == null) {
            match = {};
        } else {
            lastId = mongoose.Types.ObjectId(lastId);
            match = {
                "messages._id": { $lt: lastId },
            };
        }
        //     condition = [
        //         { $match: { _id: chatId } },
        //         { $unwind: "$messages" },
        //         { $match: match },
        //         { $sort: { "messages._id": -1 } },
        //         { $limit: noOfItems },
        // {
        //     $group: {
        //         _id: "$_id",
        //         messages: { $push: "$messages" },
        //         users: { $addToSet: "$users" },
        //         unmatched: { $first: "$unmatched" },
        //         deActivated: { $first: "$deActivated" },
        //     },
        //         },
        //         {
        //             $project: {
        //                 users: 1,
        //                 messages: 1,
        //                 unmatched: 1,
        //                 deActivated: 1,
        //             },
        //         },
        //     ];
        //     chat.aggregate(condition, (err, results) => {
        //         if (err) {
        //             logger.error(
        //                 "chatDBService.getMessages: Error getting messages: " +
        //                     chatId +
        //                     JSON.stringify(err)
        //             );
        //             return reject(err);
        //         }
        //         if (results != null && results[0] != null) {
        //             var resultElem = results[0];
        //             if (
        //                 resultElem.users != null &&
        //                 resultElem.users[0] != null
        //             ) {
        //                 resultElem.users = resultElem.users[0];
        //             }
        //             if (resultElem.messages != null) {
        //                 resultElem.messages = resultElem.messages.reverse();
        //             }
        //             // populate for user data
        //             chat.populate(
        //                 resultElem,
        //                 {
        //                     path: "userDetails",
        //                     select:
        //                         "facebookId displayName firebaseToken blocked isAdmin profilePics",
        //                 },
        //                 (err, populated) => {
        //                     if (err) {
        //                         logger.error(
        //                             "chatDBService.getMessages: Error getting messages for chatId: " +
        //                                 chatId +
        //                                 " err: " +
        //                                 JSON.stringify(err)
        //                         );
        //                         return reject(err);
        //                     }
        //                     s3Service
        //                         .getOnePicForAllUsers(populated.userDetails)
        //                         .then((userDetails) => {
        //                             populated.userDetails = userDetails;
        //                             return resolve(populated);
        //                         })
        //                         .catch((err) => {
        //                             logger.error(
        //                                 "chatDBService.getMessages: Error getting signed s3 url: " +
        //                                     imageUrl +
        //                                     " err: " +
        //                                     JSON.stringify(err)
        //                             );
        //                             return reject(err);
        //                         });
        //                 }
        //             );
        //         } else {
        //             return resolve({});
        //         }
        //     });
    });
};
exports.updateUnreadCount = (unread, chatId, userUId) => {
    logger.debug(
        "chatDBService.updateUnreadCount: updating unread message " +
            unread +
            " for chatId: " +
            chatId +
            " userid: " +
            userUId
    );
    return new Promise((resolve, reject) => {
        chat.findOne(
            {
                _id: chatId,
            },
            (err, result) => {
                if (err) {
                    logger.error(
                        "chatDBService.updateUnreadCount: Error finding chat with ChatId: " +
                            chatId +
                            JSON.stringify(err)
                    );
                    return reject(err);
                }
                var count = 0;
                if (result != null) {
                    var users = result.users;
                    for (index in users) {
                        if (users[index].userid == userUId) {
                            if (unread == 0) {
                                users[index].unread = unread;
                            } else {
                                users[index].unread =
                                    parseInt(users[index].unread) +
                                    parseInt(unread);
                            }
                            count = users[index].unread;
                        }
                    }
                    result.users = users;
                    result.save((errSave, chat) => {
                        if (errSave) {
                            logger.error(
                                "chatDBService.updateUnreadCount: Posting unread count, for chatId: " +
                                    chatId +
                                    " userd: " +
                                    userUId +
                                    " error: " +
                                    JSON.stringify(errSave)
                            );
                            return reject(errSave);
                        }
                        logger.debug(
                            "chatDBService.updateUnreadCount: unread post: " +
                                count +
                                " for chatId: " +
                                chatId +
                                " userd: " +
                                userUId
                        );
                        return resolve(count);
                    });
                } else {
                    return reject(
                        "chatDBService.updateUnreadCount: no chat found with this Id!" +
                            chatId
                    );
                }
            }
        );
    });
};
// getUnreadCount: (userid) => {
//     logger.debug(
//         "chatDBService.getUnreadCount: get unread messages count for userId: " +
//             userid
//     );
//     var totalChatCount = 0;
//     return new Promise((resolve, reject) => {
//         async.parallel(
//             [
//                 (callback) => {
//                     chat.find(
//                         {
//                             "users.userid": { $in: userid },
//                         },
//                         "users",
//                         (err, chats) => {
//                             if (err) {
//                                 logger.error(
//                                     "chatDBService.getUnreadCount: error, get unread count, find chat for userId: " +
//                                         userFBId +
//                                         " error: " +
//                                         JSON.stringify(err)
//                                 );
//                                 return reject(err);
//                             }
//                             for (index in chats) {
//                                 var users = chats[index].users;
//                                 for (j in users) {
//                                     if (users[j].facebookId == userid) {
//                                         totalChatCount =
//                                             totalChatCount +
//                                             parseInt(users[j].unread);
//                                     }
//                                 }
//                             }
//                             return callback(null, totalChatCount);
//                         }
//                     );
//                 },
//                 (callback) => {
//                     notification.findOne(
//                         { userid: userid },
//                         "notifications.read",
//                         (err, results) => {
//                             if (err) {
//                                 logger.error(
//                                     "chatDBService.getUnreadCount: error, get unread count, find fb details " +
//                                         "for userId: " +
//                                         userid +
//                                         " error: " +
//                                         JSON.stringify(err)
//                                 );
//                                 return reject(err);
//                             }
//                             if (results != null) {
//                                 notifications = results.notifications;
//                                 var notifCount = notifications.filter(
//                                     (notif) => {
//                                         return notif.read === "false";
//                                     }
//                                 ).length;
//                                 return callback(null, notifCount);
//                             } else {
//                                 return callback(null, 0);
//                             }
//                         }
//                     );
//                 },
//             ],
//             (err, results) => {
//                 if (err) {
//                     logger.error(
//                         "chatDBService.getUnreadCount: error, get unread count, for userId: " +
//                             userid +
//                             JSON.stringify(err)
//                     );
//                     return reject(err);
//                 }
//                 logger.debug(
//                     "chatDBService.getUnreadCount: total chat count: " +
//                         results[0] +
//                         " notif: " +
//                         results[1]
//                 );
//                 var result = { chat: results[0], notif: results[1] };
//                 return resolve(result);
//             }
//         );
//     });
// },
// unmatch: (chatId, userid) => {
//     logger.debug(
//         "chatDBService.unmatch: unmatching chatId " +
//             chatId +
//             " by user: " +
//             userid
//     );
//     return new Promise((resolve, reject) => {
//         chat.findOneAndUpdate(
//             { _id: chatId },
//             {
//                 $set: {
//                     unmatched: true,
//                     unmatchedBy: userid,
//                     unmatchedOn: new Date(),
//                 },
//             },
//             function (err, chat) {
//                 if (err) {
//                     logger.error(
//                         "chatDBService.unmatch: error, unmatching," +
//                             chatId +
//                             " for userId: " +
//                             userid +
//                             " err: " +
//                             JSON.stringify(err)
//                     );
//                     return reject(err);
//                 }
//                 return resolve(chat.unmatched);
//             }
//         );
//     });
// },
// report: (userId, myId, chatId, reportReason) => {
//     logger.debug(
//         "chatDBService.report: reporting user: " +
//             userId +
//             " by user: " +
//             myId
//     );
//     return new Promise((resolve, reject) => {
//         async.parallel(
//             [
//                 (callback) => {
//                     fbUser.findByFBIdAndUpdate(
//                         myId,
//                         {
//                             $push: {
//                                 reported: userId,
//                             },
//                         },
//                         (err, user) => {
//                             if (err) {
//                                 logger.error(
//                                     "chatdbService.report: Error reporting user: " +
//                                         userId +
//                                         " by: " +
//                                         myId +
//                                         " err: " +
//                                         JSON.stringify(err)
//                                 );
//                                 return callback(err);
//                             }
//                             return callback(null, myId);
//                         }
//                     );
//                 },
//                 (callback) => {
//                     var reportedBy = {};
//                     reportedBy.fbId = myId;
//                     reportedBy.reason = reportReason;
//                     reportedBy.when = new Date();
//                     fbUser.findByFBIdAndUpdate(
//                         userId,
//                         {
//                             $push: {
//                                 reportedBy: reportedBy,
//                             },
//                             $inc: {
//                                 abuseCount: 1,
//                             },
//                         },
//                         (err, user) => {
//                             if (err) {
//                                 logger.error(
//                                     "chatDBService.report: error, report, findUser for userId: " +
//                                         userId +
//                                         " myId: " +
//                                         myId +
//                                         JSON.stringify(err)
//                                 );
//                                 return callback(err);
//                             }
//                             if (user.abuseCount % 5 === 0) {
//                                 // send email
//                                 var sub =
//                                     "Report user: " +
//                                     userId +
//                                     " " +
//                                     user.abuseCount +
//                                     " times. ";
//                                 var text =
//                                     "The user " +
//                                     userId +
//                                     " has been reported for abuse " +
//                                     user.abuseCount +
//                                     " times. ";
//                                 emailService
//                                     .sendEmail(
//                                         config.email.adminEmail,
//                                         sub,
//                                         text,
//                                         null
//                                     )
//                                     .then((response) => {
//                                         return callback(null, response);
//                                     })
//                                     .catch((err) => {
//                                         logger.error(
//                                             "chatDBService.report: error sending email to admin " +
//                                                 userId +
//                                                 " err: " +
//                                                 JSON.stringify(err)
//                                         );
//                                         return callback(err);
//                                     });
//                             } else {
//                                 return callback(
//                                     null,
//                                     constants.SUCCESS_STATUS
//                                 );
//                             }
//                         }
//                     );
//                 },
//                 (callback) => {
//                     chat.findOneAndUpdate(
//                         { _id: chatId },
//                         {
//                             $set: {
//                                 unmatched: true,
//                                 unmatchedBy: myId,
//                                 unmatchedOn: new Date(),
//                             },
//                         },
//                         (err, chat) => {
//                             if (err) {
//                                 logger.error(
//                                     "chatDBService.report: error, report, update chat for userId: " +
//                                         userId +
//                                         " myId: " +
//                                         myId +
//                                         JSON.stringify(err)
//                                 );
//                                 return callback(err);
//                             }
//                             return callback(null, chatId);
//                         }
//                     );
//                 },
//             ],
//             (err, results) => {
//                 if (err) {
//                     logger.error(
//                         "chatDBService.report: error, report, for userId: " +
//                             userId +
//                             " myId: " +
//                             myId +
//                             JSON.stringify(err)
//                     );
//                     return reject(err);
//                 }
//                 if (
//                     results[0] != null &&
//                     results[1] != null &&
//                     results[2] != null
//                 ) {
//                     logger.info("Report user successful!: " + userId);
//                     return resolve(constants.SUCCESS_STATUS);
//                 } else {
//                     return reject(new Error("Error reporting user"));
//                 }
//             }
//         );
//     });
// },
exports.chatExists = (user1, user2) => {
    return new Promise((resolve, reject) => {
        chat.findOne(
            { "users.userid": { $all: [user1, user2] } },
            "_id users",
            (err, chatData) => {
                if (err) {
                    logger.error(
                        "dateDBService.chatExists: Error finding if chat exists already: " +
                            user1 +
                            " and: " +
                            user2 +
                            JSON.stringify(err)
                    );

                    return reject(err);
                    // ignore for now.
                }
                return resolve(chatData);
            }
        );
    });
};
exports.createChat = (messager,reciever, mutualmessage) => {
    return new Promise((resolve, reject) => {
        var chat_user = {
            users: [
                { userid: messager._id, unread: 0 },
                { userid: reciever._id, unread: 1 },
            ],
            lastTimestamp: new Date(),
        };

        var chatId = null;
        chat.create(chat_user, (err, chatDoc) => {
            if (err) {
                logger.error(
                    "dateDBService.createChat: Error adding chat connection: " +
                        messager +
                        " and: " +
                        reciever +
                        JSON.stringify(err)
                );
                return reject(err);
            }
            chatId = chatDoc._id;

            var message = mutualmessage;
            //post the first message
            var payload = {
                title: "GO REFER CONNECTION",
                body: message,
            };
            postAdminMessage(chatId, message, messager)
                .then((status) => {
                    logger.info(
                        "chat creation: posted first message: " + chatId
                    );
                    firebaseService.sendPushNotif(
                        reciever.firebaseToken, //.split(':')[1]
                        payload
                    );
                    console.log(reciever.firebaseToken); //.split(':')[1]);

                    return resolve(chatId);
                })
                .catch((err) => {
                    logger.error(
                        "chat creation: Error posting first message: " +
                            chatId +
                            " err: " +
                            JSON.stringify(err)
                    );
                    return reject(err);
                });
        });
    });
};
var postAdminMessage = (chatId, message, messager) => {
    logger.info(
        "chatDBService.postAdminMessage: posting a message " +
            message +
            " for chatId: " +
            chatId
    );
    var createdAt = new Date();
    return new Promise((resolve, reject) => {
        chat.updateOne(
            { _id: chatId },
            {
                $set: { lastMessage: message, lastTimestamp: createdAt },
            }
        )
            .then(async (result) => {
                await new Message({
                    chatId: chatId,
                    userid: messager._id,
                    messages: [{ message: message, createdAt: createdAt }],
                }).save((err, result) => {
                    if (err) {
                        logger.error(
                            "chatDbService.postAdminMessage: Error updating a admin chat message with chatId: " +
                                chatId +
                                JSON.stringify(err)
                        );
                        return reject(err);
                    }

                    return resolve();
                });
            })
            .catch((err) => {
                logger.error(
                    "chatDbService.postAdminMessage: Error updating a admin chat message with chatId: " +
                        chatId +
                        JSON.stringify(err)
                );
                return reject(err);
            });
    });
};
