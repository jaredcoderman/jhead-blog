---
title: "The Hack of the Decade: SolarWinds"
date: 2025-05-04
tags: ["supply chain", "initial access", "cybersecurity", "MITRE"]
---

On March 26, 2020, a hacker group identified by Microsoft as **Nobelium** launched what is widely considered the biggest supply chain hack of the 21st century. Known as the **SolarWinds Hack**, this event wasn’t significant because it affected a single company—it was significant because it compromised software used by thousands of organizations, including 6 U.S. federal agencies. The attackers accessed sensitive internal communications, email systems, and identity systems, potentially for months without detection.

It wasn’t until December 2020—**nine months later**—that the hack was discovered and reported by FireEye and U.S. government agencies. During that time, the attackers had **uninterrupted access** to some of the most sensitive networks in the world. It is still not fully known what they saw, stole, or left behind.

So how did this happen? How could critical infrastructure and tens of thousands of companies get compromised all at once?

---

### What Is SolarWinds Orion?

**SolarWinds Orion** is a widely-used IT monitoring platform. Organizations rely on it for:
- Network monitoring  
- System performance tracking  
- Infrastructure management across multiple environments  

Because of its role, Orion often runs with **high privileges** and deep visibility into internal systems. That made it a **prime target**—if compromised, it could act as a backdoor into entire enterprise networks.

---

### How the Attack Happened

While the exact initial access method is still unclear, it’s believed the attackers compromised SolarWinds' internal development systems **sometime in 2019**.

Once inside, they **inserted malicious code into the Orion software builds**. This backdoor, later named **SUNBURST**, was part of a digitally signed update—distributed by SolarWinds itself to customers between March and June 2020.

---

### What SUNBURST Did

The malicious code (a trojanized .NET DLL) was designed to be stealthy and modular. Here's how it worked:

#### 1. **Lay Dormant**
SUNBURST waited **12–14 days** after installation before doing anything, to avoid detection by tools that look for immediate network activity.

#### 2. **Perform Environment Checks**
It checked for:
- Security tools or sandbox environments  
- Domain names like `microsoft`, `fireeye`, or `solarwinds`  
If it found anything suspicious, it **deactivated itself.**

#### 3. **Establish C2 Over DNS**
SUNBURST communicated with its command-and-control (C2) server using **DNS tunneling**:
```bash
a1b2c3d4[.]appsync-api[.]eu-west-1[.]avsvmcloud[.]com
```
This looked like normal AWS traffic, helping it **blend in** and bypass proxies or firewalls.

#### 4. **Wait for Activation**
SUNBURST didn’t execute full commands itself. Instead, it waited to be activated by the C2 server, which only responded **if the target was valuable**. Then, the attacker could:
- Deploy second-stage payloads  
- Use **Cobalt Strike** for remote control and lateral movement  
- Harvest credentials and exfiltrate data

---

### Why It Was So Effective

What made this attack remarkable wasn't just the payload—it was the **delivery method**.

- **No phishing** or user interaction was involved  
- The malicious code was delivered via a **normal software update**  
- It was **digitally signed**, so endpoint protection trusted it  
- Thousands of systems were infected **in one shot**, through an update they *wanted* to install

This is what makes it a **supply chain attack**: SolarWinds was the trusted middleman. Once compromised, the attacker had access to everyone downstream.

---

### Key MITRE Techniques

- **T1195 – Supply Chain Compromise**  
- **T1071.004 – Application Layer Protocol: DNS**  
- **T1552.004 – Steal or Forge Authentication Certificates**  
- **T1550.004 – Pass the SAML**  
- **T1021 – Remote Services**

---

The SolarWinds hack showed the world that even the most secure networks can be undermined through the tools they trust. It forced defenders to rethink how we validate software, monitor for stealthy behavior, and manage third-party risk.
