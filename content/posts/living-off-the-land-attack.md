---
title: "Living off the Land Attacks"
date: 2025-05-02
tags: ["malware", "attacks", "cybersecurity"]
---

## A Brief History

As cyber defenses evolved beyond file-based malware, hackers and red teamers had to develop new strategies for maintaining unauthorized access to systems. While they still needed some kind of initial foothold—through things like phishing links, stolen remote desktop credentials, or other methods—once inside, maintaining access became a challenge. Antivirus software was getting stronger, and simply dropping suspicious binaries was no longer effective.

To adapt, some hackers in the 2010s developed what is now known as a **Living off the Land** (LotL) attack. This type of attack uses already trusted system tools like PowerShell, WMI, or certutil to run malicious commands, download payloads, or exfiltrate data—often without writing anything to disk. It’s hard to detect because the behavior doesn’t originate from some unknown file or process like traditional malware—it comes from legitimate processes that the system is likely already using, allowing it to blend into the background.

The term *LotL* gained traction in offensive security communities and led to the creation of the [LOLBAS project](https://lolbas-project.github.io/), which catalogs all known legitimate Windows binaries that can be abused for malicious purposes.

## The Details

These attacks rely on what are known as **LOLBins**—"Living Off the Land Binaries"—such as:
- `powershell.exe`
- `certutil.exe`
- `wmic.exe`
- `rundll32.exe`
- `mshta.exe`

These and others are used specifically because they are:
- Pre-installed on nearly all Windows systems,
- Digitally signed by Microsoft,
- Widely trusted by system defenses.

More specifically:
- `powershell.exe` is used because it offers a full scripting language that lets attackers download and execute code, read and write files, and more.
- `certutil` is commonly used for obfuscated file transfers.
- `wmic.exe` can run commands remotely and start processes on remote machines.

So as you can see, these different pre-installed binaries form a kind of hacker’s toolkit when used together. And all the while, the user has no idea—since most of these tools can be launched silently through headless or hidden execution.
