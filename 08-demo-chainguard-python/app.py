"""
Vulnerable Flask app -- same command injection as 01-demo-debian.
Running on cgr.dev/chainguard/python (Wolfi-based, no shell).
subprocess(shell=True) fails: /bin/sh does not exist.
"""

import subprocess
from flask import Flask, request, jsonify

app = Flask(__name__)


@app.route("/")
def index():
    return (
        "<h2>Ping Tool (Chainguard Python)</h2>"
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

    cmd = f"ping -c 2 {host}"
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True, timeout=10)

    return jsonify(
        command=cmd,
        stdout=result.stdout,
        stderr=result.stderr,
        returncode=result.returncode,
    )
