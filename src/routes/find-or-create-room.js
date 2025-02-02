import { getRoom } from '../controllers/get-room.js';
// import template from '../templates/room'

export async function findOrCreateRoom(req, env, ctx, data) {
  const roomId = req.params.roomId?.replace(/[^a-zA-Z0-9]/g, '-') ?? 'default-room';
  const people = await getRoom(roomId, env, ctx);
  return new Response(
    // template({ people, roomId }),
    `<html>oops</html>`, 
    { headers: { 'Content-Type': 'text/html' } }
  );
}
