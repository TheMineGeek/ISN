const mongoose = require('mongoose');

var scoreSchema = new mongoose.Schema({
  game: String,
  map: Number,
  score: Number,
  username: String
});

module.exports = mongoose.model('Score', scoreSchema);