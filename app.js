import dotenv from 'dotenv'
dotenv.config()
import createError from 'http-errors'
import express from 'express'
import path from 'path'
import { fileURLToPath } from 'url'
import cookieParser from 'cookie-parser'
import logger from 'morgan'
import cookieSession from 'cookie-session'

import roomRouter from './routes/room.js'
import apiRouter from './routes/api.js'
import predictionsRouter from './routes/predictions.js'

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(cookieSession({
  name: 'oscar-viewing-party',
  keys: [process.env.SESSION_SECRET],

  // Cookie Options
  maxAge: 24 * 60 * 60 * 1000 * 400 // 400 days, max cookie age https://developer.chrome.com/blog/cookie-max-age-expires/
}))
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.get('/', (req, res, next) => res.render('index'));
app.use('/api', apiRouter);
app.use('/predictions', predictionsRouter);
app.use('/', roomRouter);

// catch 404
app.use(function(req, res, next) {
  const stacktrace = new Array(100).fill(0).map(() => 'not found').join('\n')
  res.render('error', {
    message: 'What in the world were you thinking?',
    subheading: "Trying to visit this page, that DOESN'T EVEN EXIST",
    error: {
      status: 404,
      stack: stacktrace
    }
  })
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};
  res.locals.subheading = null

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

export default app;
