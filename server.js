const http = require("http");
const fs = require("fs");
const path = require("path");

const PORT = 8001;
const DIR = __dirname;

const server = http.createServer((req, res) => {
  let filePath = path.join(DIR, req.url === "/" ? "index.html" : req.url);

  // Prevent directory traversal
  if (!filePath.startsWith(DIR)) {
    res.writeHead(403, { "Content-Type": "text/plain" });
    res.end("Forbidden");
    return;
  }

  fs.readFile(filePath, (err, data) => {
    if (err) {
      res.writeHead(404, { "Content-Type": "text/plain" });
      res.end("404 Not Found");
      return;
    }

    const ext = path.extname(filePath);
    let contentType = "text/html";
    if (ext === ".js") contentType = "application/javascript";
    if (ext === ".css") contentType = "text/css";
    if (ext === ".json") contentType = "application/json";
    if (ext === ".svg") contentType = "image/svg+xml";
    if (ext === ".png") contentType = "image/png";
    if (ext === ".jpg" || ext === ".jpeg") contentType = "image/jpeg";

    res.writeHead(200, { "Content-Type": contentType });
    res.end(data);
  });
});

server.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}/`);
  console.log("Press Ctrl+C to stop");
});
