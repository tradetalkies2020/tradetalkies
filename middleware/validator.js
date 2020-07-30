const { check, body } = require("express-validator");
const User = require("../models/User");
exports.validator = [
    check("email")
        .isEmail()
        .withMessage("Please Enter a valid Email")
        .custom((value, { req }) => {
            return User.findOne({ 'local.email': value }).then((userDoc) => {
                if (userDoc) {
                    //console.log(`Existing user found : ${userDoc}`)
                    return Promise.reject(
                        "E-mail already exists, try something else."
                    );
                }
            });
        }),
];

exports.editValidator = [
    check("email")
        .isEmail()
        .withMessage("Please Enter a valid Email")
        .custom((value, { req }) => {
            return User.findOne({
                email: value,
                _id: { $ne: req.session.user._id },
            }).then((userDoc) => {
                if (userDoc) {
                    return Promise.reject(
                        "E-mail already exists, try something else."
                    );
                }
            });
        }),
    
];
