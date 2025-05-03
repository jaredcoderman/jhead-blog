---
title: "Simple IDS"
date: 2025-05-01
tags: ["python", "splunk", "file monitoring"]
summary: "A Python-based intrusion detection system that monitors file events and forwards logs to Splunk."
---
![Last Commit](https://img.shields.io/github/last-commit/jaredcoderman/Simple-IDS)

This project is a lightweight intrusion detection system (IDS) written in Python. It monitors directories for file events and logs any suspicious activity. The goal is to provide a simple, extensible foundation for learning how host-based detection works.

### Key Features

- Uses [`watchdog`](https://github.com/gorakhargosh/watchdog) to track file system events (create, modify, delete, move)
- Logs event details with timestamps, paths, and event types
- Supports recursive monitoring of critical directories
- Forwards log data to [Splunk](https://www.splunk.com/) via a file or HTTP input for real-time analysis

### Why I Built It

This project was inspired by a desire to better understand how host-based monitoring tools work under the hood. While enterprise solutions are more comprehensive, this system shows how file events can be tracked and logged with minimal overhead. Integrating with Splunk allowed for easy log visualization and alerting.

### Example Use Case

You can use this IDS to monitor sensitive directories like:

- `C:\Windows\System32`
- `/etc/`
- Project directories with production config files

It will flag unexpected file changes, deletions, or unauthorized modifications.

### Tech Stack

- **Python 3**
- **Watchdog** for event detection
- **Splunk Universal Forwarder** (or HTTP Event Collector)

### Future Improvements

- Add support for email or webhook alerts
- Track user/process responsible for each event (requires deeper OS integration)
- Hash comparison for file integrity monitoring (like a simplified Tripwire)

## Source Code & Demo

[Demo](https://www.youtube.com/watch?v=qe-RiYsNDZ4 )
[Repository](https://github.com/jaredcoderman/Simple-IDS)

---
