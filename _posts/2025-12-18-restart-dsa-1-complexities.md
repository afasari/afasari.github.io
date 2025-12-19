---
layout: post
title: "(Re)Start Learning Data Structure and Algorithm - Part 1, Complexities"
date: 2025-12-18
categories: [dsa]
tags: [software engineer]
author: Batiar
---

Big O notation is used to describe the efficiency of an algorithm by measuring how its execution time or space requirements grow as the input size (𝑛) increases.

## Common Time Complexities (Fastest to Slowest)

> This list ranks common algorithm complexities from most efficient to least efficient.

| Complexity      | Name         | Description                                                 | Examples                                                                       |
| --------------- | ------------ | ----------------------------------------------------------- | ------------------------------------------------------------------------------ |
| **𝑂(1)**        | Constant     | Runtime does not change with input size.                    | Accessing an array index, pushing/popping from a stack.                        |
| **𝑂(log𝑛)**     | Logarithmic  | Runtime grows slowly; input size is halved each step.       | Binary Search.                                                                 |
| **𝑂(\sqrt{𝑛})** | Square Root  | Efficiently narrows down search space for math-heavy tasks. | Trial Division (Primality Test), Finding all divisors.                         |
| **𝑂(𝑛)**        | Linear       | Runtime grows proportionally to input size.                 | Simple loop, linear search.                                                    |
| **𝑂(𝑛log𝑛)**    | Linearithmic | Slightly more than linear; common in efficient sorting.     | Merge Sort, Heap Sort.                                                         |
| **𝑂(n \* m)**   | Bi-Linear    | Time depends on two different input sizes.                  | Comparing every item in List A to List B, Matrix Multiplication (Rectangular). |
| **𝑂(𝑛^2)**      | Quadratic    | Runtime grows with the square of the input.                 | Nested loops, Bubble Sort, Insertion Sort.                                     |
| **𝑂(𝑛^3)**      | Cubic        | Three nested loops. Becomes very slow quickly.              | Naive Matrix Multiplication, Triple nested loops.                              |
| **𝑂(c^𝑛)**      | Exponential  | Time grows by a constant base (2^n, 3^n...).                | Recursive Fibonacci, power set generation.                                     |
| **𝑂(𝑛!)**       | Factorial    | Growth is massive even for small 𝑛.                         | Permutations of a string, Traveling Salesperson problem.                       |

## Data Structure Operations (Average Case)

Common operations vary in efficiency based on the underlying structure.

| Data Structure         | Access  | Search  | Insertion | Deletion |
| ---------------------- | ------- | ------- | --------- | -------- |
| **Array**              | 𝑂(1)    | 𝑂(𝑛)    | 𝑂(𝑛)      | 𝑂(𝑛)     |
| **Stack**              | 𝑂(𝑛)    | 𝑂(𝑛)    | 𝑂(1)      | 𝑂(1)     |
| **Queue**              | 𝑂(𝑛)    | 𝑂(𝑛)    | 𝑂(1)      | 𝑂(1)     |
| **Linked List**        | 𝑂(𝑛)    | 𝑂(𝑛)    | 𝑂(1)      | 𝑂(1)     |
| **Hash Table**         | N/A     | 𝑂(1)    | 𝑂(1)      | 𝑂(1)     |
| **Binary Search Tree** | 𝑂(log𝑛) | 𝑂(log𝑛) | 𝑂(log𝑛)   | 𝑂(log𝑛)  |

## Sorting Algorithm Complexity

Efficiency often depends on whether you are looking at the best, average, or worst-case scenario.

| Algorithm          | Time (Best) | Time (Average) | Time (Worst) | Space   |
| ------------------ | ----------- | -------------- | ------------ | ------- |
| **Quicksort**      | 𝑂(𝑛log𝑛)    | 𝑂(𝑛log𝑛)       | 𝑂(𝑛^2)       | 𝑂(log𝑛) |
| **Mergesort**      | 𝑂(𝑛log𝑛)    | 𝑂(𝑛log𝑛)       | 𝑂(𝑛log𝑛)     | 𝑂(𝑛)    |
| **Heapsort**       | 𝑂(𝑛log𝑛)    | 𝑂(𝑛log𝑛)       | 𝑂(𝑛log𝑛)     | 𝑂(1)    |
| **Bubble Sort**    | 𝑂(𝑛)        | 𝑂(𝑛^2)         | 𝑂(𝑛^2)       | 𝑂(1)    |
| **Insertion Sort** | 𝑂(𝑛)        | 𝑂(𝑛^2)         | 𝑂(𝑛^2)       | 𝑂(1)    |

## Big O Rules of Thumb

- **Worst Case**: Big O specifically measures the **upper bound** or worst-case scenario.
- **Iterative Loops**: A single loop is 𝑂(𝑛). Nested loops are 𝑂(𝑛^𝑘), where 𝑘 is the number of levels.

2. **Divide and Conquer**: Whenever you divide the problem in half every step, it involves log𝑛.
3. **Recursive Branching**: If a recursive function calls itself twice, it's often 𝑂(2^𝑛).
4. **Bitwise Operations**: Most bitwise operations (AND, OR, XOR) are 𝑂(1).
5. **Ignore the "small" stuff**: 𝑂(𝑛3+𝑛2+𝑛) simplifies to 𝑂(𝑛3) because the 𝑛^3 term grows so much faster that the others become irrelevant at scale.

For more detail, you can check <https://www.bigocheatsheet.com/>.
