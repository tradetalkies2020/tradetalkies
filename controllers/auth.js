const User = require("../models/User");
const { validationResult } = require("express-validator");
const logger = require("../middleware/logger");
const bcrypt = require("bcrypt");
const SALT_WORK_FACTOR = 10;
const mailService = require("../services/mailer");
const crypto = require("crypto");

exports.postSignup = (req, res, next) => {
    const errors = validationResult(req);

    const today = new Date();
    const email = req.body.email;
    const username = req.body.username;
    const password = req.body.password;
    var firebaseToken = "";
    if (req.body.firebaseToken) {
        firebaseToken = req.body.firebaseToken;
    }

    //Validation result checking//
    if (!errors.isEmpty()) {
        logger.error(errors.array());
        return res.status(200).json({
            errorMessage: errors.array()[0].msg,
            oldInput: {
                email: email,
            },
            validationErrors: errors.array(),
        });
    }

    //Generate hashed password for password
    bcrypt.genSalt(SALT_WORK_FACTOR, function (err, salt) {
        bcrypt.hash(password, salt, function (err, hash) {
            if (err) {
                throw err;
            }
            var userData = {
                email: email,
                password: hash,
                username: username,
            };

            var newUser = new User({
                local: userData,
                firebaseToken: firebaseToken,
                createdAt: today,
            });
            return newUser
                .save()
                .then((result) => {
                    res.json({ message: "User signed up" });
                })
                .catch((err) => {
                    const error = new Error(err);
                    error.httpStatusCode = 500;
                    return next(error);
                });
        });
    });
};

exports.postLogout = (req, res, next) => {
    req.session.destroy((err) => {
        console.log(err);
        res.json({ message: "User loggged out." });
    });
};

//Password reset Logic
exports.postReset = (req, res, next) => {
    crypto.randomBytes(32, (err, buffer) => {
        if (err) {
            console.log(err);
            return reject(err);
        }
        //const currentUser=req.session.user;
        const token = buffer.toString("hex");
        const email = req.body.email;
        const subject = "Password Reset Request";
        const content = `
    <p>You requested a password reset</p>
    <p>Click this <a href="${process.env.APP_URL}/reset/${token}">link</a> to set a new password.</p>
  `;
        const mail = mailService.sendResetEmail(email, subject, content, token);
        mail.then((result) => {
            return res.json({
                message: result.message,
                resetToken: token,
                expiration: result.expiration,
            });
        }).catch((err) => {
            return res.json({
                message: `Error in sending mail due to : ${err}`,
            });
        });
    });
};

exports.getNewPassword = (req, res, next) => {
    const token = req.params.token;
    User.findOne({
        resetToken: token,
        resetTokenExpiration: { $gt: Date.now() },
    })
        .then((user) => {
            if (!user) {
                return res.json({ message: "Token expired or no user found" });
            }
            res.json({
                userId: user._id.toString(),
                passwordToken: token,
            });
        })
        .catch((err) => {
            const error = new Error(err);
            error.httpStatusCode = 500;
            return next(error);
        });
};

exports.postNewPassword = (req, res, next) => {
    const newPassword = req.body.password;
    const userId = req.body.userId;
    const passwordToken = req.body.passwordToken;
    let resetUser;

    try {
        User.findOne({
            resetToken: passwordToken,
            resetTokenExpiration: { $gt: Date.now() },
            _id: userId,
        }).then((user) => {
            resetUser = user;
            bcrypt.genSalt(SALT_WORK_FACTOR, function (err, salt) {
                bcrypt.hash(newPassword, salt, (err, hash) => {
                    if (err) {
                        throw err;
                    }
                    resetUser.password = hash;
                    resetUser.resetToken = undefined;
                    resetUser.resetTokenExpiration = undefined;
                    resetUser.save();
                    return res.json({ message: "Password changes saved!" });
                });
            });
        });
    } catch (err) {
        const error = new Error(err);
        error.httpStatusCode = 500;
        return next(error);
    }
};

exports.mergedLogin = (req, res, next) => {
    const errors = validationResult(req);

    const today = new Date();
    const email = req.body.email;
    const username = req.body.username;
    const password = req.body.password;
    var firebaseToken = "";
    if (req.body.firebaseToken) {
        firebaseToken = req.body.firebaseToken;
    }

    //Validation result checking//
    if (!errors.isEmpty()) {
        logger.error(errors.array());
        return res.status(200).json({
            errorMessage: errors.array()[0].msg,
            oldInput: {
                email: email,
            },
            validationErrors: errors.array(),
        });
    }

    //Generate hashed password for password
    bcrypt.genSalt(SALT_WORK_FACTOR, function (err, salt) {
        bcrypt.hash(password, salt, function (err, hash) {
            if (err) {
                throw err;
            }
            var userData = {
                email: email,
                password: hash,
                username: username,
            };

            var newUser = new User({
                local: userData,
                firebaseToken: firebaseToken,
                createdAt: today,
            });
            return newUser
                .save()
                .then((result) => {
                    req.session.isLoggedIn = true;
                    req.session.user = newUser;
                    req.session.save();
                    res.json({ message: "User signed up" });
                })
                .catch((err) => {
                    const error = new Error(err);
                    error.httpStatusCode = 500;
                    return next(error);
                });
        });
    });
};

exports.androidGoogleAuth = (req, res, next) => {
    const username = req.body.userName;
    const email = req.body.email;
    const uid = req.body.uid;
    const today = Date.now();
    const firebaseToken = req.body.firebaseToken;
    User.findOne({ "google.id": uid }).then((user) => {
        if (!user) {
            logger.info(
                `No user found for google id : ${uid}, creating new user`
            );
            console.log(
                `No user found for google id : ${uid}, creating new user`
            );
            var googleData = { name: username, id: uid, email: email };
            var newUser = new User({
                google: googleData,
                createdAt: today,
                firebaseToken: firebaseToken,
            });
            newUser.save();
            req.session.user = newUser;
            req.session.isLoggedIn = true;
            req.session.save();
            return res.json({
                message: `Google user with userid : ${uid} signed up and logged in`,
            });
        } else {
            let updateUser = user;
            logger.info(`Existing user found for google id : ${uid}.`);
            console.log(`Existing user found for google id : ${uid}.`);
            updateUser.firebaseToken = firebaseToken;
            updateUser.save();
            return res.json({
                message: `Google user was existing therefore, updated firebaseToken only.`,
            });
        }
    });
};
