const express = require("express");
const router = express.Router();
const helpController=require('../controllers/admin/help');
const { validator } = require("../middleware/validator");
const isAuth = require("../middleware/isAuth");

router.post("/updateHelpCategory",helpController.updateHelpCategories);


module.exports = router;
