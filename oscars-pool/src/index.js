/**
 * Welcome to Cloudflare Workers! This is your first worker.
 *
 * - Run `npm run dev` in your terminal to start a development server
 * - Open a browser tab at http://localhost:8787/ to see your worker in action
 * - Run `npm run deploy` to publish your worker
 *
 * Learn more at https://developers.cloudflare.com/workers/
 */

// import handleProxy from './proxy';
// import handleRedirect from './redirect';
// import apiRouter from './router';
import { Router } from 'itty-router';
import { getNominees } from './routes/get-nominees';
import { returnPathParams } from './routes/return-path-params';
import { getRoom } from './routes/get-room';
import { joinRoom } from './routes/join-room';

// now let's create a router (note the lack of "new")
const router = Router();

router.get('/api/nominees/', getNominees);
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

export default {
  fetch: router.handle,
};
