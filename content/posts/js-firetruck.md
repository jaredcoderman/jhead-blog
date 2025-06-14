---
title: "The JSFireTruck Situation"
date: 2025-05-04
tags: ["JavaScript", "injection", "malware"]
---

## Background

Recently, cybersecurity researchers discovered a large-scale campaign compromising legitimate websites via JavaScript injection — over 269,000 in just the last month.

These malicious injections are obfuscated using a humorously named service called [JSFuck](https://jsfuck.com/), which has since been renamed "JSFireTruck" by security researchers to avoid profanity. The service uses just six characters: ``[] () ! +`` to write and execute JavaScript code. This is made possible through JavaScript’s loose type coercion rules and strange expression evaluation. Surprisingly, it's just normal JavaScript — no special library required — and it can even run on Node.js.

The obfuscation mainly hinders analysis and slows down response. However, researchers discovered that the injected code checks the website’s `document.referrer`, meaning the visitor must have come from a search engine rather than typing the URL directly. If the referrer is one of several search engines, the code modifies a random DOM element to become an `<iframe>` that embeds a malicious website.

![Deobfuscated JS](jsfuck-pic.png)

The malicious URLs victims are redirected to can deliver malware, exploits, traffic monetization mechanisms, and malvertising.

---

## Moving Forward

It's not yet clear exactly how the code is being injected. It's surprising that the published write-ups focus mostly on the obfuscation technique (JSFireTruck) without addressing the initial infection vector.

Injections like this typically happen through cross-site scripting (XSS) vulnerabilities, often via insecure or outdated WordPress plugins. Given that WordPress powers about 43.5% of the web, it's likely the attackers discovered a vulnerability in a widely used plugin and are exploiting it at scale. This is also supported by the fact that over 50,000 sites were reportedly infected in a single day.

This theory could be investigated by checking the infected sites with a service like [BuiltWith](https://builtwith.com/), but I haven’t found a compiled list of affected websites in Palo Alto's telemetry data. It's also possible the situation is more complex — if it were a simple plugin flaw, it likely would have been included in their [write-up](https://unit42.paloaltonetworks.com/malicious-javascript-using-jsfiretruck-as-obfuscation/).

When I asked ChatGPT how the injection could have occurred, it offered a few additional possibilities. Besides plugin vulnerabilities, the attackers might have compromised a commonly used JavaScript library or content delivery network (CDN). If more details become available, I’ll be sure to update this article.



---
