// DELIBERATELY VULNERABLE — a fixture for code scanning (CodeQL js/command-line-injection,
// critical). It gives cajeX's code-scanning template an open critical alert to find.
// Never run it, never copy it.
'use strict';

const http = require('http');
const { exec } = require('child_process');
const url = require('url');

http.createServer((req, res) => {
  const { dir } = url.parse(req.url, true).query;
  exec('ls ' + dir, (err, out) => res.end(out));
}).listen(8080);
