const restify = require('restify');
const mongoose = require('mongoose');


const app = restify.createServer();

mongoose.connect('mongodb://localhost:27017/projetISN');

const Score = require('./app/models/Score');

app.use(restify.queryParser());
app.use(restify.bodyParser());

app.get('/', function(req, res) {
  res.send();
});

app.get('/stats/:game/:mapID/:numbers', function(req, res) {
  Score.find({ game: req.params.game, map: req.params.mapID }, (err, elements) => {
    if (err) throw err;
    
    elements = elements.sort(predicatBy('score'));

    if(elements.length >= req.params.numbers)
      res.json(elements.slice(0, req.params.numbers));
    else 
      res.json(elements.slice(0, elements.length));
  });
});

app.post('/add', (req, res) => {
  var test = new Score({
    username: req.params.username,
    score: req.params.score,
    game: req.params.game
  });
  
  if(req.params.map) test.map = req.params.map;

  test.save((err) => {
    if (err) throw err;
    res.send('done');
  });
});

app.listen(80);

function predicatBy(prop) {
  return (a, b) => {
    if (a[prop] > b[prop]) {
      return 1;
    } else if (a[prop] < b[prop]) {
      return -1;
    }
    return 0;
  }
}