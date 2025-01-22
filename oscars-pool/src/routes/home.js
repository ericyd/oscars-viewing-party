import template from '../templates/home'

export function home() {
  return new Response(
    template({}),
    { headers: { 'Content-Type': 'text/html' } }
  );
}
