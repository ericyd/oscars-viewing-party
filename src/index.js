import { Router } from 'itty-router';
import { getAllNominees } from './routes/get-all-nominees.js';
// import { getRoom } from './routes/get-room.js';
import { joinRoom } from './routes/join-room.js';
import { getNominees } from './routes/get-nominees.js';
import { getUserPredictions } from './routes/get-user-predictions.js';
import { getCategories } from './routes/get-categories.js';
import { upsertPredictions } from './routes/upsert-predictions.js';
import { declareWinner } from './routes/declare-winner.js';
import { upsertPrediction } from './routes/upsert-prediction.js';
import { home } from './routes/home.js';
import { findOrCreateRoom } from './routes/find-or-create-room.js';

// now let's create a router (note the lack of "new")
const router = Router();

router.get('/', home);
router.post('/find-or-create-room', findOrCreateRoom);
router.get('/api/categories', getCategories);
router.get('/api/all-nominees/:year', getAllNominees);
router.get('/api/nominees/:year', getNominees);
router.post('/api/prediction/:year', upsertPrediction);
// currently not used, can remove
router.post('/api/predictions/:year', upsertPredictions);
router.get('/api/room/:roomId/person/:userId', getUserPredictions);
// router.get('/api/room/:roomId', getRoom);
router.post('/api/room/:roomId/join', joinRoom);
router.post('/api/winner/:year', declareWinner);

// 404 for everything else
router.all('*', (req, env, ctx, data) =>
  Response.json(
    {
      req,
      ctx,
      data,
      success: false,
      error: 'Route not found',
    },
    { status: 404 },
  ),
);

/*
redirect example
const url = new URL(request.url);
const redirectUrl = url.searchParams.get('redirectUrl'); // get a query param value (?redirectUrl=...)

if (!redirectUrl) {
	return new Response('Bad request: Missing `redirectUrl` query param', { status: 400 });
}

// The Response class has static methods to create common Response objects as a convenience
return Response.redirect(redirectUrl);
*/

export default {
  fetch: router.handle,
};
