const restify = require('restify');
const mongoose = require('mongoose');


const app = restify.createServer();

mongoose.connect('mongodb://localhost:27017/projetISN');

const Score = require('./app/models/Score');

app.use(restify.queryParser());
app.use(restify.bodyParser());

app.get('/stats/:game/:numbers', function(req, res) {
  console.log(req.params.game);
  console.log(req.params.numbers);
  Score.find({ game: req.params.game }, (err, elements) => {
    if (err) throw err;
    
    elements = elements.sort(predicatBy('score'));

    if(elements.length >= 10)
      res.json(elements.slice(0, 10));
    else 
      res.json(elements.slice(0, elements.length));
  });
});

app.post('/add', (req, res) => {
  console.log(req.params);
  var test = new Score({
    username: req.params.username,
    score: req.params.score,
    game: req.params.game
  });

  test.save((err) => {
    if (err) throw err;
    res.send('done');
  });
});

app.listen(80);

function predicatBy(prop) {
  return function(a, b) {
    if (a[prop] > b[prop]) {
      return 1;
    } else if (a[prop] < b[prop]) {
      return -1;
    }
    return 0;
  }
}