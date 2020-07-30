const crypto = require("crypto");
const nodemailer = require("nodemailer");
const sendgridTransport = require("nodemailer-sendgrid-transport");
const User = require("../models/User");

const transporter = nodemailer.createTransport(
    sendgridTransport({
        auth: {
            api_key: process.env.NODEMAILER_AUTH_KEY,
        },
    })
);

exports.sendResetEmail = (to, sub, content, token) => {
    const excpiration = "";
    return new Promise((resolve, reject) => {
        User.findOne({
            $or: [
                { "local.email": to },
                { "google.email": to },
                { "facebook.email": to },
                { "linkedin.email": to },
            ],
        })
            .then((user) => {
                if (!user) {
                    return reject("No user with that email id");
                }
                console.log(user);
                user.resetToken = token;
                user.resetTokenExpiration = Date.now() + 3600000;
                expiration = user.resetTokenExpiration;
                return user.save();
            })
            .then((result) => {
                transporter.sendMail({
                    to: to,
                    from: "admin@tradetalkies.com",
                    subject: sub,
                    html: content,
                });
                resolve({
                    message: "Password reset link sent",
                    expiration: expiration,
                });
            })
            .catch((err) => {
                const error = new Error(err);
                error.httpStatusCode = 500;
                return reject(error);
            });
    });
};
