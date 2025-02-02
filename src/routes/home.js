// import template from '../templates/home'
import { renderToString, ssrRenderComponent } from 'vue/server-renderer';
import { createApp } from '../app.js'

export async function home() {

  // server.js (irrelevant code omitted)

// server.get('/', (req, res) => {
  
// })
  const app = createApp();
  // const buf = await ssrRenderComponent(app)
  const html = await renderToString(app);
  return new Response(
    `
    <!doctype html>
    <html lang="en">
      <head>
        <meta charset="UTF-8" />
        <link rel="icon" href="/favicon.ico" />
        <meta name="viewport" content="width=device-width, minimum-scale=1, initial-scale=1.0" />
        <title>Oscars viewing party</title>
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link href="https://fonts.googleapis.com/css2?family=Inter+Tight:ital,wght@0,700;1,700&display=swap" rel="stylesheet" />
        <!-- <link rel='stylesheet' href='/stylesheets/style.css' /> -->
      </head>
      <body>
        <div id="app">${html}</div>
        <script type="module" src="./main.js"></script>
      </body>
    </html>
    `,
    { headers: { 'Content-Type': 'text/html' } }
  );
}
