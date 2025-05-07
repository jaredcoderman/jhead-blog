---
title: "Aho-Corasick Algorithm (WIP)"
date: 2025-05-06
tags: ["data structures", "algorithms"]
---

When building my project [Process Sentinel](../../projects/process-sentinel) I came across what I thought was an opportunity for optimization. The problem was essentially I have a list of **chains** which represent process parent-child relationships. I would compare these chains against a set of **suspicious chains** which would then report back if a process chain was suspicious and the severity of it. Initially I took a sort of naive approach:
```go
func containsExactPattern(chain []string, pattern []string) bool {
	if len(chain) < len(pattern) {
		return false
	}
	for i := 0; i <= len(chain)-len(pattern); i++ {
		match := true
		for j := 0; j < len(pattern); j++ {
			if chain[i+j] != pattern[j] {
				match = false
				break
			}
		}
		if match {
			return true
		}
	}
	return false
}
```
Here I am just doing a simple sliding window that compares a **pattern**--a given **suspicious chain**--against each process in a chain. While this absolutely works for this project and any optimization would absolutely be over-engineering. I was curious if there was a better way to do this if I had a very large amount of **patterns** to check against a given chain. 

Enter the **Aho-Corasick Algorithm**. This came up while I was talking to ChatGPT about the problem and I had to take a shot at understanding it. It took me a little while to fully understand, but I learned a lot about data structures along the way.

## The Algorithm

The data structure it works with is called a **Trie**--a tree-like data structure that stores **strings**, typically to enable fast prefix-based lookups. Each node in a trie usually represents a single character, and a path from the root to a node usually represents a **prefix**. In my case, each node represents a **process name** (e.g., powershell.exe, mishta.exe), and the path from the root to a node is a **suspicious chain**--For example:
```bash
powershell.exe -> regsvr32.exe -> cmd.exe
```

### Building the Tree

For building the tree we start by creating the type for our Trie nodes and then a function to insert the process names in each pattern into our tree as nodes.
```go
type TrieNode struct {
	children   map[string]*TrieNode
	fail       *TrieNode
	isTerminal bool
	patterns   [][]string
}

func insert(root *TrieNode, pattern []string) {
	node := root
	for _, proc := range pattern {
		if node.children[proc] == nil {
			node.children[proc] = &TrieNode{
				children: make(map[string]*TrieNode),
			}
		}
		node = node.children[proc]
	}
	node.isTerminal = true
	node.patterns = append(node.patterns, pattern)
}

```
For clarity we are doing a `map[string]*TrieNode` because the string will represent the process name which will be used to access that processes node via a pointer. We then just make a **root node** and then for each pattern call `insert(root, pattern)`.

Next comes the real sauce of the algorithm

### Failure Links

 The beauty of the Aho-Corasick algorithm lies in each node having a **failure link**. These serve two main purpose. First, they make it so we don't have to start over if some node in the tree doesn't see the **next** process in the input. Instead of starting over we get to jump to another node somewhere else in our Trie with the same name, to see if *that* node has the next process in the input. It serves as a sort of smart backtracking approach. This is what makes it one of the most powerful string-matching algorithms out there. Its why tools like antivirus scanners, spam filters, and log monitors use it. It was not intuitive for me at first, but once understood the elegance is clear.

 So let's go over the implementation of these failure links.