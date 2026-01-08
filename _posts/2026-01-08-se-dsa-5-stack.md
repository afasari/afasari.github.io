---
layout: post
title: "(Re)Start Learning Data Structure and Algorithm - Part 5, Stack"
date: 2026-01-08
categories: [dsa]
tags: [software engineer]
author: Batiar
mermaid: true
series: (Re)Start Learning DSA
toc: true
---

## LeetCode 20: Valid Parentheses

 1. Title & Problem Goal

- **Title:** 20. Valid Parentheses
- **Goal:** Given a string `s` containing only the characters `(`, `)`, `{`, `}`, `[` and `]`, determine if the input string is valid.
- **Valid Criteria:**
  1. Open brackets must be closed by the same type of brackets.
  2. Open brackets must be closed in the correct order.
  3. Every close bracket must have a corresponding open bracket of the same type.

2. Analysis & Constraints

- **Target Complexity:** 𝑂(𝑛) time to process each character once and 𝑂(𝑛) space for the auxiliary storage.
- **Constraint:** 1≤s.length≤104  
   . The input only contains the six specified bracket characters.
- **Optimization Hint:** If the string length is odd, it is impossible to have valid pairs, so return `false` immediately for an 𝑂(1) early exit.

3. Approaches Comparison Table

| Approach            | Logic                                                                                                                             | Time     | Space    | Pros/Cons                                                             |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------------- | -------- | -------- | --------------------------------------------------------------------- |
| **Brute Force**     | Repeatedly replace matching pairs (e.g., `()`, `{}`, `[]`) with an empty string until none remain.                                | 𝑂(𝑛^2)   | 𝑂(1)     | Simple to grasp but highly inefficient for large strings.             |
| **Stack (Optimal)** | Push opening brackets onto a **Last-In-First-Out (LIFO)** stack. Pop the top when a closing bracket is met and check for a match. | **𝑂(𝑛)** | **O(𝑛)** | Highly efficient; handles nested structures perfectly.                |
| **Recursion**       | Treat each balanced segment as a sub-problem, recursing whenever a new open bracket starts.                                       | 𝑂(𝑛)     | 𝑂(𝑛)     | More complex to implement and risk of stack overflow on deep nesting. |

4. Testing Strategy

**Standard Cases:**

- `s = "()"` → `true`
- `s = "()[]{}"` → `true`
- `s = "{[]}"` → `true`

**Edge Cases (Boundaries):**

- **Odd Length:** `s = "((("` → `false`.
- **Only Opening:** `s = "{"` → `false`.
- **Only Closing:** `s = "]"` → `false`.
- **Wrong Order:** `s = "([)]"` → `false`.

**Negative Cases:**

- **Type Mismatch:** `s = "(]"` → `false`.
- **Nested Mismatch:** `s = "{[(])}"` → `false`.

5. Optimal Code & Why (Golang)

**Why this is optimal:** A stack is the ideal data structure because the last bracket opened is the first one that should be closed (LIFO principle). Using a `map` for bracket pairs makes the code cleaner and easily extensible for more bracket types.

```go
func isValid(s string) bool {
    // 1. Early exit for odd length
    if len(s)%2 != 0 {
        return false
    }

    // 2. Map closing brackets to opening ones
    pairs := map[rune]rune{
        ')': '(',
        ']': '[',
        '}': '{',
    }

    // 3. Stack to store opening brackets
    stack := []rune{}

    for _, char := range s {
        // If it's a closing bracket
        if opener, ok := pairs[char]; ok {
            // Check if stack is empty or top doesn't match
            if len(stack) == 0 || stack[len(stack)-1] != opener {
                return false
            }
            // Pop from stack
            stack = stack[:len(stack)-1]
        } else {
            // Push opening bracket onto stack
            stack = append(stack, char)
        }
    }

    // 4. Return true if all brackets were matched
    return len(stack) == 0
}
```

6. Reflection / Mistake Log

- **The "Empty Stack" Trap:** Forgetting to check if the stack is empty _before_ popping for a closing bracket (e.g., `s = "]"`) is a common source of index out-of-range errors.
- **The "Remaining Stack" Trap:** Simply finishing the loop isn't enough; you must check that the stack is empty at the end (e.g., `s = "(("` is invalid).
- **Character Handling:** Using `rune` in Go is standard for character manipulation, though `byte` works here since the input is restricted to basic ASCII.

---

## LeetCode 155: Min Stack

1. Title & Problem Goal

- **Title:** 155. Min Stack
- **Goal:** Design a stack that supports standard operations (`push`, `pop`, `top`) and a special operation (`getMin`) that retrieves the minimum element in the stack.
- **Constraint:** Every operation—including `getMin`—must run in**𝑂(1)** time.

2. Analysis & Constraints (2026 Data)

- **Time Complexity Requirement:** 𝑂(1) for all methods. A simple stack that searches for the minimum on-demand would be 𝑂(𝑛) for `getMin`, which is unacceptable.
- **Space Complexity:** 𝑂(𝑛) to store the elements.
- **Key Insight:** Since we can only `pop` the most recent element, the "minimum" value for any given state of the stack can be pre-calculated and stored. We need to keep track of the "minimum so far" at every level of the stack.

3. Approaches Comparison Table

| Approach                  | Logic                                                                  | Time Complexity   | Space Complexity | Pros/Cons                                                                 |
| ------------------------- | ---------------------------------------------------------------------- | ----------------- | ---------------- | ------------------------------------------------------------------------- |
| **Search on `getMin`**    | Standard stack; iterate through all elements to find min.              | 𝑂(𝑛) for `getMin` | 𝑂(𝑛)             | Fails the 𝑂(1) requirement.                                               |
| **Two Stacks (Optimal)**  | Main stack for values; "Min Stack" to store the minimum at each state. | **𝑂(1)**          | **𝑂(𝑛)**         | Easy to implement and very reliable.                                      |
| **Value & Min Pair**      | Store each element as a pair: `(value, min_at_this_level)`.            | 𝑂(1)              | 𝑂(𝑛)             | Cleanest code; similar to two stacks but uses one slice of structs.       |
| **Math Trick (Encoding)** | Store `2*val - min` to derive the previous min.                        | 𝑂(1)              | 𝑂(1) _extra_     | Avoids extra space but risky due to **Integer Overflow** in 2026 systems. |

4. Testing Strategy

**Standard Cases:**

- `Push(5), Push(2), Push(10), GetMin()`→ `2`.
- `Pop(), GetMin()` → `2`.

**Edge Cases (Boundaries):**

- **Single Element:** `Push(1), GetMin()` → `1`.
- **Identical Values:** `Push(2), Push(2), Pop(), GetMin()` → `2`.
- **Decreasing Sequence:** `Push(3), Push(2), Push(1), GetMin()` → `1`.

**Negative Cases:**

- **Empty Stack:** Calling `Pop` or `GetMin` on an empty stack (The problem usually assumes valid calls, but 2026 production code should handle it).
- **Negative Values:** `Push(-10), Push(-20), GetMin()` → `-20`.

5. Optimal Code & Why (Golang)

**Why this is optimal:** This implementation uses a "Value & Min Pair" approach with a slice of structs. It ensures that every time we push a value, we calculate the minimum relative to that specific stack depth. This avoids the overhead of managing two separate slices while maintaining 𝑂(1) access.

```go
type Node struct {
    val int
    min int
}

type MinStack struct {
    stack []Node
}

func Constructor() MinStack {
    return MinStack{stack: []Node{}}
}

func (this *MinStack) Push(val int) {
    newMin := val
    // If stack isn't empty, compare new val with current min
    if len(this.stack) > 0 {
        currentMin := this.stack[len(this.stack)-1].min
        if currentMin < newMin {
            newMin = currentMin
        }
    }
    // Push the pair onto the stack
    this.stack = append(this.stack, Node{val: val, min: newMin})
}

func (this *MinStack) Pop() {
    if len(this.stack) > 0 {
        this.stack = this.stack[:len(this.stack)-1]
    }
}

func (this *MinStack) Top() int {
    return this.stack[len(this.stack)-1].val
}

func (this *MinStack) GetMin() int {
    return this.stack[len(this.stack)-1].min
}
```

6. Reflection / Mistake Log

- **Redundant Min Pushes:** In the "Two Stacks" approach, a common mistake is only pushing to the `minStack` if the new value is _strictly less_ than the current min. This fails when there are duplicate minimum values. If you pop one, you lose the record of the other. The "Pair" approach used above avoids this entirely.
- **Memory Efficiency:** While the math encoding trick (2𝑥−𝑚𝑖𝑛) saves space, it is rarely used in 2026 interviews because it's difficult to read and prone to overflow. Struct-based stacks are much more "production-ready."
- **Go Slice Reallocation:** For high-performance Go, if the maximum size is known, pre-allocating the slice with `make([]Node, 0, capacity)` can prevent multiple 𝑂(𝑛) reallocations during `Push` operations. Go Slice Performance Guidelines.

---

## LeetCode 150: Evaluate Reverse Polish Notation

1. Title & Problem Goal

- **Title:** 150. Evaluate Reverse Polish Notation
- **Goal:** Evaluate the value of an arithmetic expression in **Reverse Polish Notation** (Postfix).
- **Operators:** Valid operators are `+`, `-`, `*`, and `/`.
- **Key Rule:** Each operand may be an integer or another expression. Division between two integers should truncate toward zero.

2. Analysis & Constraints (2026 Data)

- **Input Size (𝑛):** Up to 10^4 tokens.
- **Target Complexity:** **𝑂(𝑛)** time (single pass) and **𝑂(𝑛)** space (stack to store operands).
- **RPN Logic:** In Postfix notation, the operator follows its operands (e.g., `3 4 +` instead of `3 + 4`). This removes the need for parentheses or operator precedence rules.
- **Truncation toward zero:** In Go, integer division `a / b` naturally truncates toward zero, which matches the problem requirement.

3. Approaches Comparison Table

| Approach            | Logic                                                                                       | Time Complexity | Space Complexity | Pros/Cons                                                                   |
| ------------------- | ------------------------------------------------------------------------------------------- | --------------- | ---------------- | --------------------------------------------------------------------------- |
| **Recursive**       | Evaluate from the end of the array backwards.                                               | 𝑂(𝑛)            | 𝑂(𝑛)             | More complex to implement; risk of stack overflow on very long expressions. |
| **Stack (Optimal)** | Push numbers; when an operator is found, pop the last two, apply operator, and push result. | **𝑂(𝑛)**        | **𝑂(𝑛)**         | **Most Optimized.** Cleanest implementation of LIFO logic.                  |

4. Testing Strategy

**Standard Cases:**

- `tokens = ["2","1","+","3","*"]` → `((2 + 1) * 3) = 9`.
- `tokens = ["4","13","5","/","+"]` → `(4 + (13 / 5)) = 6`.

**Edge Cases (Boundaries):**

- **Single Token:** `["42"]`→ `42`.
- **Negative Results:** `["4","-11","*"]` → `-44`.
- **Truncation Check:** `["10","3","/"]` → `3` (toward zero). `["10","-3","/"]` → `-3`.

**Negative Cases:**

- Large results that might overflow 32-bit integers (Go `int` is 64-bit on most 2026 systems, which handles the problem's 10^9 range easily).

5. Optimal Code & Why (Golang)

**Why this is optimal:** A stack is the natural data structure for RPN because an operator always applies to the two most recently seen (or computed) values. Using a `switch` statement makes the logic for different operators highly readable.

```go
func evalRPN(tokens []string) int {
    stack := []int{}

    for _, t := range tokens {
        // 1. Check if token is an operator
        if t == "+" || t == "-" || t == "*" || t == "/" {
            // 2. Pop the two most recent operands
            // Important: second pop is the left-side operand
            v2 := stack[len(stack)-1]
            v1 := stack[len(stack)-2]
            stack = stack[:len(stack)-2]

            // 3. Apply operation and push result
            switch t {
            case "+":
                stack = append(stack, v1+v2)
            case "-":
                stack = append(stack, v1-v2)
            case "*":
                stack = append(stack, v1*v2)
            case "/":
                stack = append(stack, v1/v2)
            }
        } else {
            // 4. Token is a number, convert and push
            val, _ := strconv.Atoi(t)
            stack = append(stack, val)
        }
    }

    return stack[0]
}
```

6. Reflection / Mistake Log

- **Operand Order:** The biggest mistake in RPN is the order of subtraction and division. The first value popped is the **divisor** (right side), and the second value popped is the **dividend** (left side). `v1 / v2`, not `v2 / v1`.
- **Integer Conversion:** Using `strconv.Atoi` is efficient for string-to-int conversion in Go.
- **Truncation:** Many languages handle division differently for negative numbers (e.g., floor vs. truncate). Go's `/` operator aligns with the "truncate toward zero" rule required here.
- **2026 Performance:** If memory allocation is a concern, and you know the max size of the stack (it cannot exceed `len(tokens)`), pre-allocating the slice with `make([]int, 0, len(tokens))` avoids multiple internal slice grows. Go Slice Pre-allocation.

---

## LeetCode 739: Daily Temperatures

 1. Title & Problem Goal

- **Title:** 739. Daily Temperatures
- **Goal:** Given an array of integers `temperatures`, return an array `answer` such that `answer[i]` is the number of days you have to wait after the 𝑖𝑡ℎ day to get a warmer temperature.
- **Condition:** If there is no future day for which this is possible, keep `answer[i] == 0` instead.

2. Analysis & Constraints (2026 Data)

- **Input Size (𝑛):** Up to 10^5.
  - An 𝑂(𝑛^2) brute-force approach (checking all days ahead for every single day) will result in 10^10 operations, causing **Time Limit Exceeded (TLE)**.
  - Target Complexity: **𝑂(𝑛)** time.
- **Problem Pattern:** This is a classic **"Next Greater Element"** problem.
- **Key Insight:** We need to keep track of indices of days we haven't found a warmer day for yet. A **Monotonic Decreasing Stack** is the perfect tool for this.

3. Approaches Comparison Table

| Approach            | Logic                                                                                                               | Time Complexity | Space Complexity | Pros/Cons                                                       |
| ------------------- | ------------------------------------------------------------------------------------------------------------------- | --------------- | ---------------- | --------------------------------------------------------------- |
| **Brute Force**     | For each day, iterate through all following days until a warmer one is found.                                       | 𝑂(𝑛2)           | O(1)             | Simple but unusable for large 𝑛.                                |
| **Monotonic Stack** | Use a stack to store indices of temperatures. If current temp is warmer than stack top, pop and calculate distance. | **𝑂(𝑛)**        | **𝑂(𝑛)**         | **Most Optimized.** Each element is pushed/popped exactly once. |

4. Testing Strategy

**Standard Cases:**

- `temperatures = [73, 74, 75, 71, 69, 72, 76, 73]` → `[1, 1, 4, 2, 1, 1, 0, 0]`.

**Edge Cases (Boundaries):**

- **Strictly Increasing:** `[30, 40, 50, 60]` → `[1, 1, 1, 0]`.
- **Strictly Decreasing:** `[60, 50, 40, 30]` → `[0, 0, 0, 0]`.
- **All Same:** `[40, 40, 40]` → `[0, 0, 0]`.

**Negative Cases:**

- Single day: `[30]` → `[0]`.
- Large jump: `[30, 30, 30, 100]` → `[3, 2, 1, 0]`.

5. Optimal Code & Why (Golang)

**Why this is optimal:** The monotonic stack stores indices of days whose "warmer day" hasn't been found. When we encounter a temperature warmer than the one at the index on top of the stack, we know we've found the "wait time" for that day. This ensures we only process each element once, resulting in linear time.

```go
func dailyTemperatures(temperatures []int) []int {
    n := len(temperatures)
    ans := make([]int, n)
    // Monotonic stack to store indices
    stack := []int{}

    for i, currTemp := range temperatures {
        // While stack is not empty AND current temp is warmer than stack top index's temp
        for len(stack) > 0 && currTemp > temperatures[stack[len(stack)-1]] {
            // Pop the index
            prevIndex := stack[len(stack)-1]
            stack = stack[:len(stack)-1]

            // Calculate the distance (wait time)
            ans[prevIndex] = i - prevIndex
        }
        // Push current index onto stack
        stack = append(stack, i)
    }

    return ans
}
```

6. Reflection / Mistake Log

- **Storing Indices vs. Values:** A common mistake is trying to store the temperature values in the stack. You **must store the indices** to calculate the distance (`i - prevIndex`).
- **While vs. If:** Beginners often use an `if` instead of a `for` loop to check the stack. If the current temperature is much warmer than the last few days, it might resolve multiple pending indices at once.
- **The Zero default:** In Go, `make([]int, n)` initializes the slice with zeros. This automatically handles the "no warmer day found" requirement without extra logic.
- **2026 Performance Tip:** In high-throughput Go services, if you know the maximum temperature range is small (e.g., 30-100), you could optimize further using an array-based approach, but the Monotonic Stack remains the gold standard for general interview scenarios. Go Slice Performance.

---

## LeetCode 853: Car Fleet

1. Title & Problem Goal

- **Title:** [853. Car Fleet](https://leetcode.com/problems/car-fleet/)
- **Goal:** Determine how many distinct **car fleets** arrive at a `target` mile marker.
- **Rules:** 𝑛 cars start at different `position[i]` with unique `speed[i]`.
  - Cars travel in a single lane and **cannot pass** each other.
  - If a faster car catches a slower one, it slows down and they form a **fleet** moving at the slower car's speed.
  - A single car is also considered a fleet.

2. Analysis & Constraints

- **Key Logic:** Calculate the **time** each car takes to reach the target (𝑇𝑖𝑚𝑒=𝑇𝑎𝑟𝑔𝑒𝑡−𝑃𝑜𝑠𝑖𝑡𝑖𝑜𝑛𝑆𝑝𝑒𝑒𝑑).
- **Processing Order:** Sort cars by their starting position in **descending order** (closest to the target first).
- **Constraints:** 𝑛 up to 10^5.
  - Positions are unique.
- **Target Complexity:** **𝑂(𝑛log𝑛)** due to sorting; the subsequent pass is **𝑂(𝑛)**.

1. Approaches Comparison Table

| Approach             | Logic                                                                                                          | Time Complexity | Space Complexity     | Pros/Cons                                                        |
| -------------------- | -------------------------------------------------------------------------------------------------------------- | --------------- | -------------------- | ---------------------------------------------------------------- |
| **Simulation**       | Model every mile marker step-by-step.                                                                          | 𝑂(𝑇𝑎𝑟𝑔𝑒𝑡×𝑛)     | 𝑂(𝑛)                 | Highly inefficient for large targets.                            |
| **Monotonic Stack**  | Store arrival times. If a car behind takes less/equal time than the car ahead, it merges (stack remains same). | **𝑂(𝑛log𝑛)**    | **𝑂(𝑛)**             | Clear visualization of fleets using a stack.                     |
| **Greedy (Pointer)** | Similar to stack but only tracks the `lastFleetTime`. If `currTime > lastFleetTime`, it's a new fleet.         | **𝑂(𝑛log𝑛)**    | **𝑂(1)**(after sort) | **Most Optimized.** Space efficient as it avoids stack overhead. |

4. Testing Strategy

**Standard Cases:**

- `target = 12, pos = [10,8,0,5,3], speed = [2,4,1,1,3]` → `3` fleets.
- `target = 10, pos = [3], speed = [3]` → `1` fleet.

**Edge Cases (Boundaries):**

- **Single Car:** `n = 1` always returns 1.
- **All Merge:** `target = 100, pos = [0,2,4], speed = [4,2,1]` → `1` fleet.
- **No Merges:** Faster cars are already closer to the target.

**Negative Cases:**

- Cars starting at position 0.
- Speeds resulting in fractional arrival times (e.g., (10−7)/2=1.5); use `float64` for precision.

5. Optimal Code & Why (Golang)

**Why this is optimal:** Sorting by position ensures we process cars from the target backwards. If a car behind reaches the target slower than the fleet ahead (`time > lastTime`), it cannot join that fleet and must start a new one.

```go
type car struct {
    pos  int
    time float64
}

func carFleet(target int, position []int, speed []int) int {
    n := len(position)
    cars := make([]car, n)
    for i := 0; i < n; i++ {
        // Calculate arrival time: (target - pos) / speed
        cars[i] = car{position[i], float64(target-position[i]) / float64(speed[i])}
    }

    // Sort by position descending (closest to target first)
    sort.Slice(cars, func(i, j int) bool {
        return cars[i].pos > cars[j].pos
    })

    fleets := 0
    var lastTime float64

    for _, c := range cars {
        // If this car takes LONGER than the fleet in front, it forms a NEW fleet
        if c.time > lastTime {
            fleets++
            lastTime = c.time
        }
        // Else: it arrives faster/same time but is blocked, joining the front fleet
    }

    return fleets
}
```

6. Reflection / Mistake Log

- **Sorting Order:** A common mistake is sorting by speed. You **must** sort by position; the car ahead dictates the fleet's speed.
- **Stack vs. Greedy:** While many tutorials use a `stack`, you only actually need to know the arrival time of the _current_ fleet's leader to determine if the next car joins it.
- **Precision:** Always use `float64` for time calculations to avoid integer division errors that could falsely group or separate fleets.
- **Tie-breaking:** Per 2026 standards, if two cars reach the target at the exact same time, they are considered one fleet.

---

## LeetCode 84: Largest Rectangle in Histogram

1. Title & Problem Goal

- **Title:** 84. Largest Rectangle in Histogram
- **Goal:** Given an array of integers `heights` representing the histogram's bar height where the width of each bar is 1, find the area of the largest rectangle in the histogram.
- **Key Insight:** A rectangle's height is limited by the **shortest bar** within its range. To find the maximum area, for every bar, we need to find the first bar to its left and right that is **shorter** than itself.

2. Analysis & Constraints (2026 Data)

- **Input Size (𝑛):** Up to 10^5.
  - An 𝑂(𝑛^2) solution (checking every possible pair of boundaries) will result in 10^10 operations, leading to **Time Limit Exceeded (TLE)**.
  - Target Complexity: **𝑂(𝑛)**.
- **Problem Pattern:** This is a **Monotonic Stack** problem. We need to maintain a stack of bars in increasing order of height.
- **Constraints:** `heights[i] >= 0`. Bars can have zero height, which effectively breaks a rectangle.

3. Approaches Comparison Table

| Approach             | Logic                                                                                                 | Time Complexity  | Space Complexity | Pros/Cons                                            |
| -------------------- | ----------------------------------------------------------------------------------------------------- | ---------------- | ---------------- | ---------------------------------------------------- |
| **Brute Force**      | Check every pair (𝑖,𝑗) and find the minimum height between them.                                      | 𝑂(𝑛^3) or 𝑂(𝑛^2) | 𝑂(1)             | Simple but unusable for 𝑛=10^5.                      |
| **Divide & Conquer** | Max area is either in the left half, right half, or across the min bar.                               | 𝑂(𝑛log𝑛) avg     | 𝑂(log𝑛)          | 𝑂(𝑛^2) worst case (sorted input).                    |
| **Monotonic Stack**  | Use a stack to track indices. When a shorter bar appears, pop and calculate areas for the popped bar. | **𝑂(𝑛)**         | **𝑂(𝑛)**         | **Most Optimized.** Processes each bar exactly once. |

4. Testing Strategy

**Standard Cases:**

- `heights =` → `10` (The rectangle formed by bars [5, 6]).
- `heights =` → `4`.

**Edge Cases (Boundaries):**

- **Strictly Increasing:** ``→`6` (last bar 3 _width 2 = 6, or bar 2_ width 3).
- **Strictly Decreasing:** ``→`6`.
- **All Same Height:** ``→`10`.

**Negative Cases:**

- **Single Bar:** ``→`2`.
- **Zero Heights:** ``→`2`.

5. Optimal Code & Why (Golang)

**Why this is optimal:** We use a stack to store pairs of `(start_index, height)`. We maintain a **monotonic increasing** stack. When we see a bar shorter than the top of the stack, we know the taller bar's rectangle "ends" there. We pop it, calculate its area using the width from its `start_index` to the current index, and update the global max.

```go
type pair struct {
    index  int
    height int
}

func largestRectangleArea(heights []int) int {
    maxArea := 0
    stack := []pair{} // Monotonic increasing stack

    for i, h := range heights {
        start := i
        // If current height is shorter than stack top, pop and calculate area
        for len(stack) > 0 && stack[len(stack)-1].height > h {
            p := stack[len(stack)-1]
            stack = stack[:len(stack)-1]

            // Area = height of popped * (current_index - its_start_index)
            area := p.height * (i - p.index)
            if area > maxArea {
                maxArea = area
            }
            // The new bar can technically "start" from the index of the popped taller bar
            start = p.index
        }
        stack = append(stack, pair{start, h})
    }

    // Process remaining bars in stack (they extend to the end of the histogram)
    for _, p := range stack {
        area := p.height * (len(heights) - p.index)
        if area > maxArea {
            maxArea = area
        }
    }

    return maxArea
}
```

6. Reflection / Mistake Log

- **The "Start Index" logic:** The trickiest part is realizing that when you pop a taller bar, the current shorter bar's potential width extends back to the `start_index` of the bar you just popped.
- **Cleanup Phase:** Don't forget the bars left in the stack after the loop. They are bars that were never "topped" by a shorter bar, so their width extends to the very end of the array (`len(heights)`).
- **Zero Height:** A height of `0` will effectively pop everything from the stack and reset the `start_index`, which correctly models how a zero-height bar prevents any rectangle from crossing it.
- **2026 Optimization:** For high-performance Go, using a slice of a custom struct or two separate slices for indices and heights is faster than using an interface-based container. Go Performance Tips.

---
