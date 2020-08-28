const mongoose = require("mongoose");

const Schema = mongoose.Schema;

var postSchema = new Schema({
    userId: { type: Schema.Types.ObjectId, ref: "User" },
    tickers:[{type:String}],
    desc:{type:String,required:true},
    createdAt:{type:Date,default:Date.now()},
    updatedAt:{type:Date},
    likes:[{type:Schema.Types.ObjectId,ref:'User'}],
    
});

module.exports = mongoose.model("Post", postSchema);
