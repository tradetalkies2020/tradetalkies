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


