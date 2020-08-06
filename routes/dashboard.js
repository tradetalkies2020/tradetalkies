const express = require("express");
const router = express.Router();
const dashboardController=require('../controllers/users');
const { validator } = require("../middleware/validator");
const isAuth = require("../middleware/isAuth");

router.get("/user/:userid",isAuth,dashboardController.getProfile);
router.post('/help-query',isAuth,dashboardController.postHelpQuery);

module.exports = router;
