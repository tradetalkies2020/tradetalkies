module.exports = function (req, res, next) {
    // console.log(JSON.stringify(req.session));
    // console.log(req.session.isLoggedIn);
    if (!req.session.isLoggedIn) {
        return res
            .status(401)
            .json({
                message:
                    "User not authorized. You sure you are in the right place pal?",
            });
    }
    next();
};
