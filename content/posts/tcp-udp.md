---
title: "TCP and UDP: The Internet's Backbone"
date: 2025-05-24
tags: ["network", "handshake", "security"]
---

As we know, the internet is like a giant web that connects different machines to one another. They could be mainly computers, servers, or other similar devices that have internet access. The question is though, how *exactly* does the information get from one computer to another, and more importantly how can we trust that that information's transit is secure and cannot be interrupted?

Some information needs to be absolutely secure, while other information just needs to be broadcasted and it is not necessary that it reaches a specific person. Think for the first case, something like email. Email *must* be secure, because it is used for things like evidence in court, handling important proprietary documents for businesses, etc. Whereas, for the second case, take something like Livestreaming. Livestreaming is simply a *broadcast*, there is no need for someone on the other end to get the information, or for them to get it in a neatly packaged way. There are many other kinds of cases however we will focus on these two. Secure connection, and broadcasting and their associated protocols which are TCP and UDP.

---

## TCP

TCP stands for **Transmission Control Protocol** and it is the protocol for secure, reliable transfers of data. This reliability comes in the form of *getting* the data to the specific target, but also making sure it comes in the right order, and if any part of it goes missing, it waits for a resend until it gets that portion before it can continue. So let's dive deeper specifically into how this protocol works and the different parts of it.

To ensure its reliability, TCP uses something known as the **three-way handshake** between the **client** and the **server**. Here's how it works:

**1. SYN** - your computer (client) says, "Hey, are you there?"

**2. SYN-ACK** - the other computer (server) says, "Yes, are you ready?"

**3. ACK** - your computer responds, "Yes, let's do this!"

This process ensures that both parties are ready, for a connection to be made for at least a certain amount of time, to handle the transfer of whatever the payload is. Now when that data is transferred, TCP does a few things. First it breaks the data into small chunks (*segments*) and numbers them. Sends each segment, waiting for an **ACK** as confirmation that it arrived safely before sending the next one. Then along the way **resends** any data that happens to get lost, before moving on to the next segment.

So it's like:  
“Page 1, got it? Yes. Page 2? Yes. Page 3? Didn’t get it—resend!”

TCP is useful for things like loading a webpage, sending emails, and downloading files. Essentially when accuracy is more important than speed, use TCP. Now what if speed is more important than accuracy?

---

## UDP

For things like online gaming, live-streaming, zoom calls, things like that, we want to make sure we have the lowest latency possible to make it a seamless experience for the users engaging with the application. Traditionally using TCP will cause too much lag, because we need to make sure each segment gets there successfully and that just causes a lot of requests to the server and each request has a certain amount of latency so it's just not feasible to use TCP in that case. This is why UDP was created, UDP stands for **User Datagram Protocol** not that that helps you understand what it does at all, I still don't know what "datagram" means. However, that's not super important so let's dive into how UDP works differently than TCP, so that it can serve up data between clients and servers with high-speeds.

### Fire and Forget

The way of thinking about UDP is that you just fire something off and forget about it. We don't really care if the information reached anyone, we just focus on sending out information so there are no connections, acknowledgements, or resending like in TCP. However, this does mean, that we can get things like weird lag going on in our video calls, or video games, so it is not without any downsides. However, it is a necessary tradeoff for our goal.

---

## Their use in Cybersecurity

So now that we know what they are, what are some basic ways that these protocols are used/exploited in hacking.

### Ports

Every TCP or UDP connection uses a **port number** — think of it like a mailing address, it tells the operating system where the packet should go to. Hackers will send off a ton of requests to every open port to check if they are running, and then if they are they will go further to see if they are vulnerable. Usually once one of these ports is hit they send back a little message when you connect called a **banner**.

Example:

    nc target.com 22

Might return:

    SSH-2.0-OpenSSH_7.2p2 Ubuntu-4ubuntu2.10

Now the attacker will use or google known exploits for the service, in this case OpenSSH. So they might search "OpenSSH 7.2p2 CVE" (CVEs = Common Vulnerability and Exposures). To be more precise they can use version scanning with `nmap`.

Example:

    nmap -sV target.com

This gives an output like:

    22/tcp open  ssh     OpenSSH 7.2p2  
    80/tcp open  http    Apache httpd 2.4.18 ((Ubuntu))

The difference here is we can get the version number of OpenSSH and Apache, so if these services being used have not been updated in a while, it is likely there is a known exploit out there that they can easily find and use to exploit this port.

These exploits can do a number of things, it sort of depends on the hacker's goal. They could use it as [initial access](../initial-access), to start running some code they want. They could try and crash or freeze the server, leak information, or bypass authentication. This is often a first step in a larger attack.
