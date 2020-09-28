var mongoose = require("mongoose");
const logger = require("../middleware/logger");
const User = require("../models/User");
var admin = require("firebase-admin");
var _ = require("lodash");
// // var fbGraph = require('../config/fbGraph');
// var configAuth = require('../config/authConfig');
var serviceAccount = require("../tradetalkies-firebase-adminsdk-k0b48-5d74b05370.json");

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: "https://https://tradetalkies.firebaseio.com",
});
var sendDryRunMultiCast = (firebaseTokens) => {
    return new Promise((resolve, reject) => {
        var message = {
            tokens: firebaseTokens,
            data: { title: "Go Refer", body: "GoGaga: Find Love via friends!" },
        };

        // do not send the real message, only dry run
        admin
            .messaging()
            .sendMulticast(message, true)
            .then((results) => {
                return resolve(results);
            })
            .catch((err) => {
                logger.error("Error in sendMulticast: " + err);
                return reject(err);
            });
    });
};
var setPayloadDefaults = (payload) => {
    if (payload.title == null) {
        payload.title = "constants.GO_GAGA";
    }
    if (payload.body == null) {
        payload.body = "constants.DEFAULT_FIREBASE_NOTIF_TEXT";
    }
    return payload;
};
var getFirebaseMessage = (payload, firebaseToken, analytics_label) => {
    if (analytics_label == null) {
        analytics_label = "unlabelled";
    }
    // check if no non-strings are present
    Object.keys(payload).forEach((key) => {
        if (!(typeof payload[key] === "string")) {
            payload[key] = String(payload[key]);
        }
    });
    var message = {
        token: String(firebaseToken),
        android: {
            collapse_key: "gorefer",
            priority: "high",
        },
        apns: {
            payload: {
                aps: {
                    alert: {
                        title: String(payload.title),
                        body: String(payload.body),
                    },
                },
                "content-available": "1",
                sound: "default",
            },
        },
        data: payload,
        notification: {
            title: String(payload.title),
            body: String(payload.body),
        },
        fcm_options: {
            analytics_label: analytics_label,
        },
    };
    return message;
};
exports.sendPushNotif = (firebaseToken, payload) => {
    if (payload == null) {
        return;
    } else {
        payload = {
            notification: { title: payload.title, body: payload.body },
        };
    }
    if (firebaseToken != null && firebaseToken !== "") {
        
     
        var options={priority:'high',timeToLive:60*60*24};
        admin.messaging().sendToDevice(firebaseToken,payload,options).then(response=>
            {
                logger.info("Succesfully sent message ", response);
            }).catch(err=>
                {
                    logger.error("Error in sending notification to user",err);
                });
       
    } else {
        // ignore for now. TODO: Thing abt it later what to do.
        logger.info(
            "firebaseDBService.sendNotif: Error sending blank message: " +
                payload
        );
    }
};
exports.sendNotification = (firebaseToken, payload, analytics_label) => {
    if (payload == null) {
        return;
    } else {
        payload = setPayloadDefaults(payload);
    }
    if (firebaseToken != null && firebaseToken !== "") {
        var message = getFirebaseMessage(
            payload,
            firebaseToken,
            analytics_label
        );
        logger.info("Notification before sending: " + JSON.stringify(message));
        admin
            .messaging()
            .send(message)
            .then(function (response) {
                logger.info(
                    "firebaseDBService.sendNotif: Successfully sent message to: " +
                        firebaseToken
                );
            })
            .catch(function (error) {
                logger.info(
                    "firebaseDBService.sendNotif: Error sending message to: " +
                        firebaseToken +
                        " error: " +
                        error
                );
            });
    } else {
        // ignore for now. TODO: Thing abt it later what to do.
        logger.info(
            "firebaseDBService.sendNotif: Error sending blank message: " +
                payload
        );
    }
};
// var sendFBNotification = (facebookId, message, ref) => {
// ​
//     return new Promise((resolve, reject) => {
//         var accessToken = configAuth.facebookAuth.clientID + "|" + configAuth.facebookAuth.clientSecret
//         //fbGraph.graph.setAccessToken(accessToken);
//         var endpoint = "/" + facebookId + "/notifications?ref=" + ref + "&template=" + message + "&access_token=" + accessToken;
// //         fbGraph.graph
// //             .post(endpoint, function (err, response) {
// //                 if (err) {
// //                     logger.error("firebaseDBSerice.sendFBNotif: Error while sending FB notifs: " + facebookId +
// //                         " err: " + JSON.stringify(err));
// //                     return reject(err);
// //                 }
// // ​
// //                 return resolve(response);
// //             });
//     });
// };
// ​
//module.exports = {
// refreshToken: (fbId, token, from) => {

//     return new Promise((resolve, reject) => {
//         if(token != null) {
//             logger.info("FirebaseDBService: Refreshing firebase token for from: " + from + " fbId: " + fbId +
//                     " token: " + token);
//             User.findByUIdAndUpdate(fbId, {$set: {"firebaseToken": token}}, (err, user) => {
//                 if (err) {
//                     logger.error("FirebaseDBService.refreshToken: Error updating the refresh token for user: " + fbId + " Err: " + JSON.stringify(err));
//                     return reject(err);
//                 }
//                 return resolve(token);
//             });
//         } else {
//             logger.warn("FirebaseDBService: RefreshToken firebase token is null: " + fbId + " from: " + from);
//             return resolve(token);
//         }
//     });
// },

//     sendNotificationSync: (firebaseToken, payload, analytics_label) => {
//         return new Promise((resolve, reject) => {
//             if(payload == null) {
//                 return;
//             } else {
//                 payload = setPayloadDefaults(payload);
//             }
// ​
//             if(firebaseToken != null && firebaseToken !== "") {
//                 var message = getFirebaseMessage(payload, firebaseToken, analytics_label);
// ​
//                 logger.info("Notification before sending: " + JSON.stringify(message));

//                 admin.messaging().send(message)
//                     .then(function(response) {
//                         logger.info("firebaseDBService.sendNotif: Successfully sent message to: " + firebaseToken);
//                         return resolve();
//                     })
//                     .catch(function(error) {
//                         logger.warn("firebaseDBService.sendNotif: Error sending message to: " + firebaseToken + " error: " + error);
//                         return reject();
//                     });
//             } else {
//                 // ignore for now. TODO: Thing abt it later what to do.
//                 logger.error("firebaseDBService.sendNotif: Error sending blank message: " + payload);
//             }
//         });
//     },
//     sendDryRunMultiCast: sendDryRunMultiCast,
//     sendFBNotification: sendFBNotification
//}
