const User = require("../models/User");
const Constants = require("../models/constants");
const Help = require("../models/Help");
const userservices = require("../services/userservices");
const async = require("async");
const { v4: uuidv4 } = require("uuid");
const { validationResult } = require("express-validator");
const logger = require("../middleware/logger");
const upload = require("../config/s3Service");
const singleUpload = upload.single("image");

exports.getProfile = (req, res, next) => {
    const currentUser = req.session.user;
    if (currentUser) {
        var id = req.params.userid;
        var query = { _id: id };

        if (id.toString() === currentUser._id.toString()) {
            User.findOne({ _id: currentUser._id }, function (err, user_) {
                res.json({
                    currentuser: user_,
                });
            });
        } else {
            User.findOne(query, { password: 0 }, function (err, user) {
                if (err || !user) {
                    // if user profile not found, redirect to homepage
                    res.json({ message: `No user find for id: ${id}` });
                } else {
                    console.log(currentUser);
                    User.findOne(
                        {
                            _id: currentUser._id,
                        },
                        function (err, user_) {
                            res.json({
                                user: user,
                                currentUser: user_,
                            });
                        }
                    );
                }
            });
        }
    } else {
        res.status(401).json({
            message:
                "User not authorized. You sure you are in the right place pal?",
        });
    }
};

//This controller is for posting help queries in the help section
exports.postHelpQuery = (req, res, next) => {
    const category = req.body.category;
    const currentUser = req.session.user;
    const description = req.body.description;
    const today = new Date();
    const unique = uuidv4();
    //Can also include image files, for evidence
    Constants.findOne({ name: "help_category" })
        .select("value")
        .then((value) => {
            let helpCat = value.value;
            if (helpCat.includes(category)) {
                //If correct catgory found
                let helpData = {
                    userId: currentUser._id,
                    token: unique,
                    createdAt: today,
                    description: description,
                    helpType: category,
                };
                new Help(helpData).save();
                return res.json({
                    message: `Query added for user ID:${currentUser._id}.`,
                    token: unique,
                    helpData: helpData,
                });
            } else {
                return res.json({
                    errorMessage: `Error in posting help query for id : ${currentUser._id}`,
                });
                //If category does not exist logic
            }
        });
};

exports.editProfile = async (req, res, next) => {
    const currentUser = req.session.user;
    const name = req.body.name;
    const email = req.body.email;
    const industry = req.body.industry;
    const age = req.body.age;
    const firebaseToken = req.body.firebaseToken;
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        logger.error(errors.array());
        return res.status(200).json({
            errorMessage: errors.array()[0].msg,
            oldInput: {
                email: email,
                name: name,
                age: age,
                industry: industry,
            },
            validationErrors: errors.array(),
        });
    }
    var imageUrl = {};

    //Find user type logic..
    let userPromise = userservices.userType(currentUser._id);
    let userType = await userPromise
        .then((type) => {
            return type.type;
        })
        .catch((err) => {
            return err;
        });
    let update = {};
    if (userType === "local") {
        update = {
            "local.name": name,
            "local.email": email,
            age: age,
            industry: industry,
            firebaseToken: firebaseToken,
        };
    }

    if (userType === "linkedin") {
        update = {
            "linkedin.name": name,
            "linkedin.email": email,
            age: age,
            industry: industry,
            firebaseToken:firebaseToken
        };
    }
    if (userType === "google") {
        update = {
            "google.name": name,
            "google.email": email,
            age: age,
            industry: industry,
            firebaseToken:firebaseToken
        };
    }
    if (userType === "facebook") {
        update = {
            "facebook.name": name,
            "facebook.email": email,
            age: age,
            industry: industry,
            firebaseToken:firebaseToken
        };
    }
    if (userType === "twitter") {
        update = {
            "twitter.name": name,
            "twitter.email": email,
            age: age,
            industry: industry,
            firebaseToken:firebaseToken
        };
    }

    //Update logic
    // var update = {
    //     local: { username: name, email: email },
    //     age: age,
    //     industry: industry,
    // };
    Object.keys(update).forEach(
        (key) =>
            (update[key] == null || update[key] == undefined) &&
            delete update[key]
    );
    await singleUpload(req, res, function (err) {
        if (err) {
            return res.status(422).send({
                errors: [
                    {
                        title: "Error in uploading image",
                        detail: err.message,
                    },
                ],
            });
        }
    });
    if (req.file !== undefined) {
        imageUrl = await req.file.location;
    } else {
        imageUrl = "";
    }
    console.log(imageUrl);
    update.imageUrl = imageUrl;

    User.findOneAndUpdate(
        { _id: currentUser._id },
        { $set: update },
        { new: true },
        async (err, result) => {
            if (err) {
                logger.error("Error in updating user data", err);
                return res.json({
                    message: "error in updating user data",
                    err: err,
                });
            }
            return res.json({
                result: result,
                message: "User updated",
            });
        }
    );
};
