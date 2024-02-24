const baseUrl = import.meta.env.PROD ? 'https://oscars-pool.eric-13c.workers.dev/api' : 'http://localhost:8345/api';

export async function request(path, method = 'get', body = null) {
  // this could be more defensive, meh
  const response = await fetch(`${baseUrl}${path}`, { method, body: body ? JSON.stringify(body) : null });
  return response.json();
}
