---
title: "The State of ML in Cybersecurity"
date: 2025-05-01
tags: ["malware", "artificial intelligence", "cybersecurity"]
---

[Crowdstrike Article](https://www.skrasser.com/blog/2025/02/08/detecting-malware-with-machine-learning/)

While AI is on the rise and seems to be unstoppable, its applications to threat detection—specifically in cybersecurity—have yet to show great promise. Traditional approaches to applying machine learning to threat detection overlook some important factors. The first is the sheer amount of data required to train a reliable detection model. While there is no shortage of data in areas like memory usage, CPU usage, file changes, and other system activity, the data for successfully flagging actual malicious behavior—especially malware executions—is sparse.

Cybersecurity is a game of cat and mouse. When a threat is finally detected, it is usually immediately turned into a rule or signature to catch that threat in the future. So, the role of a machine learning model would be either to generate these rules automatically or to act as a detection system that flags suspicious behavior to the security team. But how exactly this would be done effectively is still unclear. And even if it were done properly, the error rate that comes with it would often not be worth the resulting "alert fatigue."

A data research team at CrowdStrike supports this perspective. Their reasoning is that threats are increasingly novel and often fileless, making the amount of data required to build a predictive model enormous. Even in an ideal scenario where a model correctly identifies 100% of malware executions, if it has a false positive rate (FPR) of just 0.00001%, it could still generate more false positives than true ones. For example, in a system with millions of daily events, a model might produce one true positive and several false positives per day. Given that the cybersecurity industry is already stretched thin in terms of available workers, this would lead to a gross inefficiency in resource allocation and increased alert fatigue among analysts.

CrowdStrike currently uses AI/ML in ways that are not specific to detection. They mainly apply it for task automation—writing tests and documentation, improving internal workflows, and accelerating operations—rather than for identifying actual threats. Despite the current limitations of AI/ML in threat detection, its potential uses in other areas of cybersecurity remain promising, and there are likely many valuable applications on the horizon.