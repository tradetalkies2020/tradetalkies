const mongoose = require("mongoose");

const Schema = mongoose.Schema;

var tickerSchema = new Schema({
   symbol:String,
   value:String
    
});

module.exports = mongoose.model("Ticker", tickerSchema);
