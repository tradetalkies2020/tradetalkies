const express = require("express");
const router = express.Router();
const helpController=require('../controllers/admin/help');
const uploadService=require('../services/upload');
const { validator } = require("../middleware/validator");
const isAuth = require("../middleware/isAuth");

router.post("/updateHelpCategory",helpController.updateHelpCategories);
router.post('/testUpload',uploadService.testUpload);

module.exports = router;
