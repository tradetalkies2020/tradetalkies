const mongoose = require("mongoose");

const Schema = mongoose.Schema;
var helpSchema = new Schema({
    userId:{type:mongoose.Schema.Types.ObjectId},
    token:{type:String,required:true},
    description:{type:String,required:true},
    createdAt:{type:Date,default:Date.now()},
    resolved:{type:Boolean,default:false},
    helpType:{type:String}
});



module.exports = mongoose.model("Help", helpSchema);

