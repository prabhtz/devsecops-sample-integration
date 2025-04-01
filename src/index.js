const http = require('http');
const url = require('url');
const port = process.env.PORT || 3000;

const requestHandler = (req, res) => {
  const parsedUrl = url.parse(req.url, true);

  if (parsedUrl.pathname === '/echo' && parsedUrl.query.message) {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ echo: parsedUrl.query.message }));
  }
  else if (parsedUrl.pathname === '/version') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ version: "1.0.0" }));
  } else {
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.end('Hello from DevSecOps Node.js App!');
  }
};

const server = http.createServer(requestHandler);

server.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
