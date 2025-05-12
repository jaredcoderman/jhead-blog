---
title: "Aho-Corasick Algorithm"
date: 2025-05-012
tags: ["data structures", "algorithms"]
---

When building my project [Process Sentinel](../../projects/process-sentinel), I came across what I thought was an opportunity for optimization. The problem was essentially I have a list of **chains** which represent process parent-child relationships. I would compare these chains against a set of **suspicious chains**, which would then report back if a process chain was suspicious and the severity of it. Initially, I took a sort of naive approach:

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

Here I am just doing a simple sliding window that compares a **pattern**—a given **suspicious chain**—against each process in a chain. While this absolutely works for this project and any optimization would absolutely be over-engineering, I was curious if there was a better way to do this if I had a very large amount of **patterns** to check against a given chain.

Enter the **Aho-Corasick Algorithm**. This came up while I was talking to ChatGPT about the problem, and I had to take a shot at understanding it. It took me a little while to fully understand, but I learned a lot about data structures along the way.

## The Algorithm

The data structure it works with is called a **Trie**—a tree-like data structure that stores **strings**, typically to enable fast prefix-based lookups. Each node in a trie usually represents a single character, and a path from the root to a node usually represents a **prefix**. In my case, each node represents a **process name** (e.g., powershell.exe, mishta.exe), and the path from the root to a node is a **suspicious chain**—for example:

```bash
powershell.exe -> regsvr32.exe -> cmd.exe
```

### Building the Tree

For building the tree, we start by creating the type for our Trie nodes and then a function to insert the process names in each pattern into our tree as nodes.
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
For clarity, we are using a `map[string]*TrieNode` because the string will represent the process name, which will be used to access that process’s node via a pointer. We then just make a **root node**, and for each pattern call insert(root, pattern).

Next comes the real sauce of the algorithm.

### Failure Links

The beauty of the Aho-Corasick algorithm lies in each node having a **failure link**. These serve two main purposes. First, they make it so we don't have to start over if some node in the tree doesn't see the **next** process in the input. Instead of starting over, we get to jump to another node somewhere else in our trie with the same name, to see if *that* node has the next process in the input. It serves as a sort of smart backtracking approach. This is what makes it one of the most powerful string-matching algorithms out there. It's why tools like antivirus scanners, spam filters, and log monitors use it.

So let's go over the implementation of these failure links:

```go
func buildFailureLinks(root *TrieNode) {
	queue := []*TrieNode{}

	for _, child := range root.children {
		child.fail = root
		queue = append(queue, child)
	}

	for len(queue) > 0 {
		current := queue[0]
		queue = queue[1:]

		for process, child := range current.children {
			fallback := current.fail
			for fallback != nil && fallback.children[process] == nil {
				fallback = fallback.fail
			}

			if fallback != nil {
				child.fail = fallback.children[process]
			} else {
				child.fail = root
			}

			if child.fail.isTerminal {
				child.patterns = append(child.patterns, child.fail.patterns...)
			}

			queue = append(queue, child)
		}
	}
}
```

First we make a queue, and append to it all the children in the first layer--A breadth first search approach. Then for each child of a given node in the queue, we follow its parent's failure link chain until one of the links has this process name as a child. If we find it, we set the first child's fail to the other child node. If we don't, we just set it to the root. If the first child is a terminal node, we add the patterns from its fail link to its patterns. Lastly, we enqueue the first child to continue the BFS.

### Searching

The final portion to implement is the **search** function. The way it works is we take in the root node and an input. We check if the current node--usually starting with the root--has the next process as a child. At each step, if the current node is a terminal node---or if any node along its failure link chain is terminal---we collect the associated patterns and add them to the matches array. Finally we return the matches array and those are the *suspicious chains* that are found within our input.

```go
func searchProcesses(root *TrieNode, input []string) (matches [][]string) {
	node := root

	for _, proc := range input {
		for node != root && node.children[proc] == nil {
			node = node.fail
		}

		if next, ok := node.children[proc]; ok {
			node = next
		} else {
			node = root
		}

		temp := node
		for temp != root {
			if temp.isTerminal {
				matches = append(matches, temp.patterns...)
			}
			temp = temp.fail
		}
	}

	return matches
}
```

## Conclusion

This algorithm was quite cool for me to learn. It took a while to get the understanding since there are a lot of moving parts, however, I feel like I have a good handle on how it works and I am excited to learn about other problems like this. Its always easier for me to get motivated to learn about an algorithm when I can see its utility in a project I am working on. I'll be taking this into account when I think about what I want to do for my next projects (likely to do with networking).
