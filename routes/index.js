import express from 'express'
const router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

router.post('/room', function(req, res, next) {
  if (!req.body?.roomId || req.body.roomId.replace(/[^a-zA-Z0-9]/g, '') === '') {
    res.render('error', { message: 'you gotta be better about including a room id' })
  }
  console.log(req.body, req.body?.roomId)
  res.render('index', { title: 'Express' });
});

router.get('/room', function(req, res, next) {
  console.log(req.query, req.query?.roomId)
  res.render('index', { title: 'Express' });
});

export default router;
