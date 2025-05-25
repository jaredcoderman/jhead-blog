---
title: "TCP and UDP: The Internet's Backbone"
date: 2025-05-24
tags: ["network", "handshake", "security"]
---

As we know, the internet is like a giant web that connects different machines to one another. These are mainly computers, servers, or other devices with internet access. But the question is: how *exactly* does information get from one computer to another? And more importantly, how can we trust that its transit is secure and won’t be interrupted?

Some information needs to be absolutely secure, while other information just needs to be broadcast — it’s not necessary that it reaches a specific person. For example, take email. Email *must* be secure because it’s used for things like court evidence, proprietary business documents, and other sensitive communication.

Now contrast that with livestreaming. Livestreaming is just a *broadcast* — there’s no need for anyone in particular to receive the data, or for it to arrive neatly and completely.

There are many other cases, but we’ll focus on these two: secure communication and general broadcasting — and the two protocols most commonly associated with them: **TCP** and **UDP**.

---

## TCP

TCP stands for **Transmission Control Protocol**, and it's used for secure, reliable data transfers. This reliability means making sure the data gets to the specific destination, in the correct order, and waiting to resend any missing parts if something goes wrong along the way.

Let’s break down how this actually works.

### The Three-Way Handshake

To ensure both sides are ready, TCP uses a process called the **three-way handshake** between the client and the server:

**1. SYN** – your computer (the client) says, “Hey, are you there?”  
**2. SYN-ACK** – the other computer (the server) replies, “Yes, are you ready?”  
**3. ACK** – your computer responds, “Yes, let’s do this!”

Once that connection is established, TCP breaks the data into smaller chunks called *segments* and numbers them. Each segment is sent one by one, and the sender waits for an **ACK** (acknowledgment) that it arrived before sending the next. If a segment gets lost, it’s resent before continuing.

It’s like:  
“Page 1, got it? Yes. Page 2? Yes. Page 3? Didn’t get it — resend!”

TCP is ideal when **accuracy matters more than speed**, like:
- Loading a webpage  
- Sending emails  
- Downloading files

But what if speed matters more?

---

## UDP

For things like online gaming, livestreaming, and Zoom calls, we want the **lowest possible latency** to make the experience smooth and real-time. Using TCP in these situations causes too much lag, because it introduces extra steps and waiting — every segment must arrive and be acknowledged before continuing, and that’s just not efficient for fast-paced communication.

This is where UDP comes in. UDP stands for **User Datagram Protocol** — not that the word “datagram” helps explain much. I still don’t really know what it means. But what matters is that UDP works very differently from TCP.

### Fire and Forget

With UDP, you just send the data and don’t wait around. There’s:
- No connection setup  
- No acknowledgments  
- No resending of dropped packets  

You fire the data off and forget about it. The priority is speed — even if that means dropping some information along the way.

Of course, this comes with tradeoffs. You might get weird lag or missing frames in a video call or game, but that’s acceptable for the sake of responsiveness. That’s the cost of speed, and it’s often worth it.

---

## Their Use in Cybersecurity

Now that we know what these protocols are, how are they actually used — or exploited — in hacking?

### Ports

Every TCP or UDP connection uses a **port number**. Think of it like a mailing address — it tells the operating system which service the incoming packet is meant for.

Hackers will often scan all ports on a machine to see which ones are open. If they find one, they’ll try to figure out what service is running behind it, and whether that service has any known vulnerabilities.

When you connect to an open port, it might return a small message called a **banner**, which can give away the service and version number.

Example:

    nc target.com 22

Might return:

    SSH-2.0-OpenSSH_7.2p2 Ubuntu-4ubuntu2.10

Now the attacker can look up known vulnerabilities by searching something like:

    OpenSSH 7.2p2 CVE

(CVE = Common Vulnerabilities and Exposures)

A more precise way to fingerprint services is with version scanning, using tools like `nmap`.

Example:

    nmap -sV target.com

This might return:

    22/tcp open  ssh     OpenSSH 7.2p2  
    80/tcp open  http    Apache httpd 2.4.18 ((Ubuntu))

Now that we know the version number of OpenSSH and Apache, an attacker can check whether those versions are out of date — and if there are any known exploits available to take advantage of them.

These exploits can do a variety of things depending on the attacker’s goals. They might:
- Use it as a foothold for [initial access](../initial-access)  
- Crash or freeze the service  
- Leak sensitive data  
- Bypass authentication

Most of the time, it’s just the beginning — the first step in a larger attack chain.
