const mongoose = require("mongoose");

const Schema = mongoose.Schema;
var constantSchema = new Schema({
    name:String,
    value:{type:Object}
});



module.exports = mongoose.model("Constant", constantSchema);

