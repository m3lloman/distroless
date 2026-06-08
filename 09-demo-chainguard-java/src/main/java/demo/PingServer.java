package demo;

import com.sun.net.httpserver.HttpServer;
import com.sun.net.httpserver.HttpExchange;
import java.io.*;
import java.net.*;
import java.nio.charset.StandardCharsets;

// Vulnerable HTTP server -- same command injection as 01-demo-debian.
// Running on cgr.dev/chainguard/jre (Wolfi-based, no shell).
// Runtime.exec(new String[]{"/bin/sh","-c",cmd}) fails: /bin/sh not found.
public class PingServer {

    public static void main(String[] args) throws Exception {
        HttpServer server = HttpServer.create(new InetSocketAddress(5000), 0);
        server.createContext("/", PingServer::handleIndex);
        server.createContext("/ping", PingServer::handlePing);
        server.start();
        System.out.println("Listening on :5000");
    }

    static void handleIndex(HttpExchange ex) throws IOException {
        String body = "<h2>Ping Tool (Chainguard Java)</h2>"
                + "<form action='/ping'>Host: <input name='host' value='8.8.8.8'>"
                + "<input type='submit' value='Ping'></form>";
        send(ex, 200, "text/html", body);
    }

    static void handlePing(HttpExchange ex) throws IOException {
        String query = ex.getRequestURI().getQuery();
        String host = "";
        if (query != null) {
            for (String p : query.split("&")) {
                if (p.startsWith("host=")) {
                    host = URLDecoder.decode(p.substring(5), StandardCharsets.UTF_8);
                }
            }
        }
        if (host.isEmpty()) {
            send(ex, 400, "application/json", "{\"error\":\"host parameter required\"}");
            return;
        }

        // Intentionally vulnerable: unsanitized input in shell command.
        // Try: ?host=8.8.8.8; id
        String cmd = "ping -c 2 " + host;
        String stdout = "", error = "";
        int returnCode = 0;
        try {
            Process proc = Runtime.getRuntime().exec(new String[]{"/bin/sh", "-c", cmd});
            proc.waitFor();
            returnCode = proc.exitValue();
            stdout = new String(proc.getInputStream().readAllBytes(), StandardCharsets.UTF_8);
        } catch (Exception e) {
            error = e.getMessage();
        }

        String json = String.format(
            "{\"command\":%s,\"stdout\":%s,\"returncode\":%d,\"error\":%s}",
            jsonStr(cmd), jsonStr(stdout), returnCode, jsonStr(error)
        );
        send(ex, 200, "application/json", json);
    }

    static String jsonStr(String s) {
        if (s == null || s.isEmpty()) return "\"\"";
        return "\"" + s.replace("\\", "\\\\").replace("\"", "\\\"")
                       .replace("\n", "\\n").replace("\r", "\\r") + "\"";
    }

    static void send(HttpExchange ex, int code, String ct, String body) throws IOException {
        byte[] bytes = body.getBytes(StandardCharsets.UTF_8);
        ex.getResponseHeaders().set("Content-Type", ct);
        ex.sendResponseHeaders(code, bytes.length);
        try (OutputStream os = ex.getResponseBody()) { os.write(bytes); }
    }
}
