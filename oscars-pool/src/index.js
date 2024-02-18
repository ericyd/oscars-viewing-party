import { Router } from 'itty-router';
import { getAllNominees } from './routes/get-all-nominees';
import { returnPathParams } from './routes/return-path-params';
import { getRoom } from './routes/get-room';
import { joinRoom } from './routes/join-room';
import { getNominees } from './routes/get-nominees';

// now let's create a router (note the lack of "new")
const router = Router();

router.get('/api/all-nominees/:year', getAllNominees);
router.get('/api/nominees/:year', getNominees);
router.get('/api/params/:id/user/:user_id', returnPathParams);
router.get('/api/room/:roomId', getRoom);
router.post('/api/room/:roomId/join', joinRoom);

// 404 for everything else
router.all('*', () =>
  Response.json(
    {
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
