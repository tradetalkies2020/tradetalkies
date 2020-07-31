const express = require("express");
const router = express.Router();
const { validator } = require("../middleware/validator");
const isAuth = require("../middleware/isAuth");

router.get("/user/:profId", (req, res, next) => {
    res.json({ message: `Welcome to user dashboard of ${req.params.profId}` });
});

module.exports = router;
