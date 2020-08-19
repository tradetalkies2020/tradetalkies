const express = require("express");
const router = express.Router();
const dashboardController = require("../controllers/users");
const { check, body } = require("express-validator");
const User = require("../models/User");
const { validator } = require("../middleware/validator");
const userLog = require("../middleware/userLog");
const UploadController = require("../services/upload");
const isAuth = require("../middleware/isAuth");

router.get("/user/:userid", isAuth, userLog, dashboardController.getProfile);
router.post("/edit-profile", isAuth, userLog, dashboardController.editProfile);
router.post("/help-query", isAuth, userLog, dashboardController.postHelpQuery);
router.post(
    "/uploadImage",
    [
        check("email")
            .optional({ checkFalsy: true })
            .isEmail()
            .withMessage("Please Enter a valid Email")
            .custom((value, { req }) => {
                return User.findOne({
                    "local.email": value,
                    _id: { $ne: req.session.user._id },
                }).then((userDoc) => {
                    if (userDoc) {
                        return Promise.reject(
                            "E-mail already exists, try something else."
                        );
                    }
                });
            }),
    ],
    dashboardController.editProfile
);

router.post("/change-password",isAuth,userLog, dashboardController.passworChange);
module.exports = router;
