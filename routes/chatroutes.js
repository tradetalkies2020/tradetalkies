const express = require("express");
const router = express.Router();
const { validator } = require("../middleware/validator");
const isAuth = require("../middleware/isAuth");
const userLog = require("../middleware/userLog");
const chatController = require("../controllers/chats");
router.post("/create-chat", isAuth, userLog, chatController.createChat);
router.get("/chat/:chatId", isAuth, userLog, chatController.getMessages);
router.post("/message", isAuth, userLog, chatController.postMessages);
router.get("/chatlist", isAuth, userLog, chatController.getChatList);
router.get(
    "/chat/:chatId/messages",
    isAuth,
    userLog,
    chatController.getMessages
);
module.exports = router;
