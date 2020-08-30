const express = require("express");
const router = express.Router();
const { validator } = require("../middleware/validator");
const isAuth = require("../middleware/isAuth");
const userLog = require("../middleware/userLog");
const postController = require("../controllers/posts");

router.post("/post", isAuth, userLog, postController.postNewPost);
router.post("/like", isAuth, userLog, postController.likePost);
router.get("/post/:postId", isAuth, userLog, postController.getPost);
router.get("/tickersuggestions", isAuth,userLog,postController.getTickerSuggestions);
module.exports = router;
