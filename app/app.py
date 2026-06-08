"""
Vulnerable Flask app demonstrating command injection (CWE-78).

The /ping endpoint passes user input directly into a shell command.
Exploitation requires /bin/sh to exist in the container -- which is
present in standard base images (ubuntu, python:3.x) but absent in
distroless images.  In distroless, subprocess(shell=True) fails at
exec() with FileNotFoundError: /bin/sh: not found.
"""

import subprocess
from flask import Flask, request, jsonify

app = Flask(__name__)


@app.route("/")
def index():
    return (
        "<h2>Ping Tool</h2>"
        "<form action='/ping'>"
        "Host: <input name='host' value='8.8.8.8'>"
        "<input type='submit' value='Ping'>"
        "</form>"
    )


@app.route("/ping")
def ping():
    host = request.args.get("host", "")
    if not host:
        return jsonify(error="host parameter required"), 400

    # Intentionally vulnerable: user input concatenated into a shell command.
    # On any image with /bin/sh this executes arbitrary commands.
    # Try: ?host=8.8.8.8; id
    # Try: ?host=8.8.8.8; cat /etc/passwd
    # Try: ?host=8.8.8.8; ls /bin
    cmd = f"ping -c 2 {host}"
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True, timeout=10)

    return jsonify(
        command=cmd,
        stdout=result.stdout,
        stderr=result.stderr,
        returncode=result.returncode,
    )
