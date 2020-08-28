const User = require("../models/User");
const Constant = require("../models/constants");
const { v4: uuidv4 } = require("uuid");
exports.userType = (userId) => {
    return new Promise((resolve, reject) => {
        User.findOne({ _id: userId })
            .then((user) => {
                if (!user) {
                    return reject({
                        errorMessage: `User not found by id ${userId}`,
                    });
                }
                if (user.local !== undefined) {
                    return resolve({ type: `local` });
                }
                if (user.google !== undefined) {
                    return resolve({ type: `google` });
                }
                if (user.facebook !== undefined) {
                    return resolve({ type: `facebook` });
                }
                if (user.twitter !== undefined) {
                    return resolve({ type: `twitter` });
                }
                if (user.linkedin !== undefined) {
                    return resolve({ type: `linkedin` });
                }
            })
            .catch((err) => {
                console.log(`Error occured at userservice:userType ->`, err);
                logger.error(`Error occured at userservice:userType ->`, err);
                return reject(err);
            });
    });
};

exports.generateRefCode = (username) => {
    const unique = uuidv4();
    return `${username.toUpperCase().substring(0, 4)}_${unique}`;
};

exports.referralBonus = (refCode) => {
    return new Promise((resolve, reject) => {
        Constant.findOne({ name: "points" })
            .select("value")
            .then((pointSet) => {
                let referValue = pointSet.value.refer;
                User.findOneAndUpdate(
                    { refCode: refCode },
                    { $inc: { points: referValue, referred: 1 } },
                    { new: true }
                )
                    .then((result) => {
                        resolve({ status: true, result: result });
                    })
                    .catch((err) => {
                        reject(err);
                    });
            })
            .catch((err) => {
                reject(err);
            });
    });
};

exports.userExists = (...userList) => {
    let userObjArr = userList.map((s) => mongoose.Types.ObjectId(s));

    return new Promise((resolve, reject) => {
        User.find({ _id: { $in: userObjArr } }, (err, results) => {
            if (err) {
                logger.error(
                    "userExists: Error finding if user exists already: " +
                        JSON.stringify(err)
                );

                // ignore for now.
            }
            return resolve(results);
        });
    });
};

exports.addPoints = (userId, points) => {
    return new Promise((resolve, reject) => {
        User.findOneAndUpdate({ _id: userId },{ $inc: { points: points }},{new:true})
            .then((user) => {
                if(!user)
                {
                    reject(`No user found wityh ID ${userId}`);
                }
                return resolve(true);

            })
            .catch((err) => {
                console.log(err);
                logger.error(`Error in finding user with user ID : ${userId}`);
                reject(err);
            });
    });
};
