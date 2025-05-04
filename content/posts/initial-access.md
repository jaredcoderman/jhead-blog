---
title: "Initial Access: Spearphishing Example"
date: 2025-05-04
tags: ["phishing", "initial access", "cybersecurity", "MITRE"]
---

In the MITRE ATT&CK Framework, which classifies and creates chains of events for certain kinds of hacker behavior, Initial Access is one of the first tactics used in an attack. It’s sort of self-explanatory—it describes how the attacker first got into a system. I’m just learning about these concepts, so I wanted to start from the beginning. I’m interested in a few techniques, and I’ll go over them in my next few posts.

Something we’ve all heard of and are familiar with is **Phishing (T1566)**, so I wanted to look deeper into the different methods behind this tactic—specifically, **Spearphishing**. Spearphishing differs from general phishing in that it is targeted. A hacker will meticulously look into a target—usually an individual with privileged accounts or status—and develop a handcrafted phishing email for them.

### Spearphishing Example

Samantha is a Senior Compliance Officer at a mid-sized financial firm.  
She frequently appears in LinkedIn posts about regulatory updates and has recently spoken on a panel about SEC reporting standards.

An attacker—posing as a recruiter from a reputable consulting firm—sends her an email:

> **Subject:** Invitation to Speak at SEC2025 Regulatory Trends Panel – Confirm Availability?

- References real names from the previous year’s panel  
- Includes a customized invitation letter as a PDF  
- Attaches a malicious Excel file (`Panel_Schedule_2025.xlsm`) that “requires macros to view timeslots”

### What Happens

When Samantha opens the Excel file and enables macros, a PowerShell script is executed. This script could do a variety of things, but let’s say it does the following:

1. **Establishes a C2 connection to a domain hidden behind FastFlux DNS**  
   - This is the malware "phoning home" to get instructions or download further tools.  
   - FastFlux allows the attacker to rapidly change the IP addresses associated with the domain, making it harder to block or take down.

2. **Drops an info-stealer**  
   - This malware reads sensitive data from the browser, including stored usernames, passwords, and cookies.

3. **Uses `regsvr32` to bypass antivirus**  
   - A Living-off-the-Land (LotL) technique using a legitimate Windows utility to register and execute malicious DLLs.  
   - Since the payload doesn’t write to disk, it avoids traditional AV detection.

4. **Attempts lateral movement using SMB and harvested credentials**  
   - If the attacker has valid credentials, they can access shared drives, copy malware to new machines, or begin mapping the internal network.

### How the Attacker Prepped

The attacker used open-source intelligence (OSINT) to build a believable lure:

- Scraped Samantha’s LinkedIn profile for her role, interests, and speaking engagements  
- Found her company’s quarterly schedule via a press release  
- Knew her team uses Microsoft 365  
- Referenced a real regulation (e.g., SEC Rule 10b-5) to appeal to her expertise and make the email feel legitimate

---

