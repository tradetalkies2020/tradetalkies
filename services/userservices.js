const User = require("../models/User");
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


exports.generateRefCode=(username)=>
{
    const unique=uuidv4();
    return `${username.toUpperCase().substring(0,4)}_${unique}`;
}

