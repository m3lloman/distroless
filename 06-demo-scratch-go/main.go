package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"os/exec"
)

type PingResponse struct {
	Command    string `json:"command"`
	Stdout     string `json:"stdout"`
	Stderr     string `json:"stderr"`
	ReturnCode int    `json:"returncode"`
	Error      string `json:"error,omitempty"`
}

func indexHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprint(w, `<h2>Ping Tool</h2><form action='/ping'>Host: <input name='host' value='8.8.8.8'><input type='submit' value='Ping'></form>`)
}

func pingHandler(w http.ResponseWriter, r *http.Request) {
	host := r.URL.Query().Get("host")
	if host == "" {
		http.Error(w, `{"error":"host parameter required"}`, http.StatusBadRequest)
		return
	}

	// Intentionally vulnerable: user input passed directly to sh -c.
	// Try: ?host=8.8.8.8; id
	// Try: ?host=8.8.8.8; cat /etc/passwd
	cmd := fmt.Sprintf("ping -c 2 %s", host)
	out, err := exec.Command("/bin/sh", "-c", cmd).CombinedOutput()

	resp := PingResponse{Command: cmd}
	if err != nil {
		if exitErr, ok := err.(*exec.ExitError); ok {
			resp.ReturnCode = exitErr.ExitCode()
		} else {
			resp.Error = err.Error()
		}
	}
	resp.Stdout = string(out)

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(resp)
}

func main() {
	http.HandleFunc("/", indexHandler)
	http.HandleFunc("/ping", pingHandler)
	fmt.Println("Listening on :5000")
	http.ListenAndServe(":5000", nil)
}
