const express = require("express");
const router = express.Router();
const { validator } = require("../middleware/validator");
const isAuth = require("../middleware/isAuth");
const userLog = require("../middleware/userLog");
const postController = require("../controllers/posts");
const repostController = require("../controllers/repost");

router.post("/post", isAuth, userLog, postController.postNewPost);
router.post("/like", isAuth, userLog, postController.likePost);
router.get("/post/:postId", isAuth, userLog, postController.getPost);
router.get(
    "/tickersuggestions",
    isAuth,
    userLog,
    postController.getTickerSuggestions
);
router.get("/all-tickers", isAuth, userLog, postController.allTickers);

//commenting logic//
router.post("/comment", isAuth, userLog, postController.postComment);
router.post("/uncomment", isAuth, userLog, postController.postDelComment);
router.get(
    "/post/:postId/comments",
    isAuth,
    userLog,
    postController.getReqComments
);

//Repost Logic
router.post("/repost", isAuth, userLog, repostController.postNewRepost);

//trending logic
router.get(
    "/trending-posts",
    isAuth,
    userLog,
    postController.dailytrendingPosts
);
router.get("/feed", postController.getFeed);

module.exports = router;
