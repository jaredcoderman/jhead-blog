---
title: "Process Sentinel (WIP)"
date: 2025-05-02
tags: ["go", "process monitoring", "threat detection"]
summary: "A Go-based tool that monitors live process trees and flags suspicious chains based on parent-child relationships."
---

`Process Sentinel` is a real-time process monitoring tool written in Go. It scans active processes on the system, builds their parent-child execution chains, and checks them for suspicious behavior patterns. It’s meant to serve as a lightweight utility for understanding how malicious process chains form and how they can be detected with simple rules.

### Key Features

- Scans all running processes using [`gopsutil`](https://github.com/shirou/gopsutil)
- Reconstructs parent-child chains for each process
- Filters out trivial repetitions and focuses on meaningful lineage
- Checks each process chain against a user-defined rule system for anomalies
- Modular design: `processmanager` handles process traversal, `chaindetector` handles logic

### Why I Built It

In many malware cases, child processes are spawned in ways that deviate from normal system behavior—like `powershell.exe` being launched by `winword.exe`, or chains where unrelated executables spawn each other. I wanted to explore how to identify those relationships by building the actual chain of execution and comparing them to known-good patterns.

This project also gave me an opportunity to work more with Go and system-level tooling, while exploring real-world detection ideas.

### Example Behavior

On a clean system, a normal chain might look like:
```bash
["explorer.exe", "cmd.exe"]
```


These are the kinds of patterns Sentinel is built to surface.

### Tech Stack

- **Go 1.21+**
- **gopsutil** for process enumeration and metadata
- Modular packages:
  - `processmanager`: fetches and builds chains
  - `chaindetector`: scores and flags suspicious chains
- Unit tests included for core modules

### Future Improvements

- Integrate YARA for memory-based rules
- Writing logs to Splunk
- Add persistence across scans to correlate behavior over time

### Code Highlights

Here’s the loop that drives the real-time monitoring:

```go
func CheckProcesses() error {
	fmt.Println("Checking Processes...")

	procs, parentMap, err := GetProcesses()
	if err != nil {
		return err
	}

	for _, p := range procs {
		chain, err := BuildProcessChain(p, parentMap)
		if err != nil {
			log.Printf("error building chain for PID %d: %v", p.Pid, err)
			continue
		}

		if isSuspicious, severity := chaindetector.CheckChain(chain); isSuspicious {
			fmt.Println("SUSPICIOUS CHAIN: ", chain, " SEVERITY: ", severity)
		}

	}
	return nil
}
```

Source Code
[Repository](https://github.com/jaredcoderman/process-sentinel)