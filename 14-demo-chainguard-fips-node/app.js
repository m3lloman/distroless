// Vulnerable Express app -- same command injection as 01-demo-debian.
// Running on cgr.dev/chainguard/node (Wolfi-based, no shell).
// exec() with shell:true fails: /bin/sh does not exist.

const express = require('express');
const { exec } = require('child_process');

const app = express();

app.get('/', (req, res) => {
  res.send('<h2>Ping Tool (Chainguard Node)</h2><form action="/ping">Host: <input name="host" value="8.8.8.8"><input type="submit" value="Ping"></form>');
});

app.get('/ping', (req, res) => {
  const host = req.query.host;
  if (!host) return res.status(400).json({ error: 'host parameter required' });

  // Intentionally vulnerable: unsanitized input in shell command.
  // Try: ?host=8.8.8.8; id
  const cmd = `ping -c 2 ${host}`;
  exec(cmd, { timeout: 10000 }, (err, stdout, stderr) => {
    res.json({
      command: cmd,
      stdout,
      stderr,
      returncode: err ? err.code || 1 : 0,
      error: err && !err.code ? err.message : undefined,
    });
  });
});

app.listen(5000, '0.0.0.0', () => console.log('Listening on :5000'));
