---
layout: post
title: "(Re)Start Learning Data Structure and Algorithm - Part 4, Two Pointers"
date: 2026-01-02
categories: [dsa]
tags: [software engineer]
author: Batiar
mermaid: true
series: (Re)Start Learning DSA
---

## LeetCode 125: Valid Palindrome

 1. Title & Problem Goal

- **Title:** 125. Valid Palindrome
- **Goal:** Determine if a string is a palindrome, considering **only alphanumeric characters** and **ignoring cases**.
- **Definition:** A palindrome reads the same forward and backward after removing non-alphanumeric characters.

2. Analysis & Constraints

- **Input Size (𝑛):** Up to 2×10^5.
  - Target Complexity:**𝑂(𝑛)** time.
- **Memory Constraint:** Can we do it in**𝑂(1)** extra space? (In-place pointers vs. creating a new string).
- **Character Set:** ASCII characters (letters, numbers, symbols, spaces).
- **Case Sensitivity:** "A" and "a" must be treated as equal.

3. Approaches Comparison Table

| Approach                   | Logic                                                                                   | Time Complexity | Space Complexity | Pros/Cons                                               |
| -------------------------- | --------------------------------------------------------------------------------------- | --------------- | ---------------- | ------------------------------------------------------- |
| **New String + Reverse**   | Filter out non-alphanumeric chars, lowercase the string, then compare with its reverse. | 𝑂(𝑛)            | 𝑂(𝑛)             | Very easy to implement; uses extra memory for the copy. |
| **Two Pointers (Optimal)** | Use two pointers (`left`, `right`). Skip invalid chars and compare values at each step. | **𝑂(𝑛)**        | **𝑂(1)**         | **Most Optimized.** No extra memory allocated.          |

4. Testing Strategy

**Standard Cases:**

- `s = "A man, a plan, a canal: Panama"` → `true` (After filtering: "amanaplanacanalpanama").
- `s = "race a car"` → `false` (After filtering: "raceacar" vs "racaecar").

**Edge Cases (Boundaries):**

- `s = " "` (Empty/Space only) → `true` (An empty string is a valid palindrome).
- `s = "a."` (Single char with symbol) → `true`.
- `s = "0P"` (Letter and number) → `false`.

**Negative Cases:**

- `s = "ab2a"` → `false`.
- Strings with only symbols like `"!!!???"` → `true`.

5. Optimal Code & Why (Golang)

**Why this is optimal:** This approach avoids creating a new string or slice, which saves 𝑂(𝑛) memory. It processes the string in a single pass (𝑂(𝑛)) using the original byte underlying the string.

```go
func isPalindrome(s string) bool {
    l, r := 0, len(s)-1

    for l < r {
        // 1. Move left pointer if not alphanumeric
        if !isAlphanumeric(s[l]) {
            l++
            continue
        }
        // 2. Move right pointer if not alphanumeric
        if !isAlphanumeric(s[r]) {
            r--
            continue
        }
        // 3. Compare characters (convert to lowercase)
        if toLower(s[l]) != toLower(s[r]) {
            return false
        }
        l++
        r--
    }
    return true
}

// Helper: Check if byte is letter or number
func isAlphanumeric(b byte) bool {
    return (b >= 'a' && b <= 'z') ||
           (b >= 'A' && b <= 'Z') ||
           (b >= '0' && b <= '9')
}

// Helper: Standardize to lowercase
func toLower(b byte) byte {
    if b >= 'A' && b <= 'Z' {
        return b + ('a' - 'A')
    }
    return b
}
```

6. Reflection / Mistake Log

- **Non-Alphanumeric skipping:** The biggest mistake is forgetting that `left` and `right` pointers might need to move multiple times before a comparison happens. Using `continue` inside a `for l < r` loop is the cleanest way to handle this.
- **The Number Trap:** Don't forget that **numbers** are part of "alphanumeric." A common error is only checking for `a-z` and `A-Z`.
- **Built-in vs Manual:** While `unicode.IsLetter` and `unicode.ToLower` exist in Go, using manual byte comparisons (as seen above) is slightly faster for standard ASCII strings because it avoids the overhead of UTF-8 decoding.
- **2026 High Performance Tip:** For competitive programming in 2026, manual byte manipulation is preferred over `strings.ToLower(s)`, as the latter creates a whole new string in memory. link Go strings package for reference on standard methods.

---

## LeetCode 167: Two Sum II - Input Array Is Sorted

 1. Title & Problem Goal

- **Title:** 167. Two Sum II - Input Array Is Sorted
- **Goal:** Given a **1-indexed** array of integers `numbers` that is already **sorted in non-decreasing order**, find two numbers such that they add up to a specific `target`.
- **Constraint:** You must use **𝑂(1) extra space**.

2. Analysis & Constraints (2026 Data)

- **Sorted Property:** This is the most critical hint. It allows us to navigate the sum predictably without using a Hash Map.
- **Input Size (𝑛):** Up to 3×10^4.
  - Target Complexity: **𝑂(𝑛)** time.
- **Memory Constraint:** **𝑂(1)** space. This explicitly forbids the Hash Map approach used in "Two Sum I" (𝑂(𝑛) space).
- **1-Indexed:** The result indices must be 1+ the standard 0-indexed position.

3. Approaches Comparison Table

| Approach          | Logic                                                                                             | Time Complexity | Space Complexity | Pros/Cons                                               |
| ----------------- | ------------------------------------------------------------------------------------------------- | --------------- | ---------------- | ------------------------------------------------------- |
| **Brute Force**   | Nested loops checking every pair.                                                                 | 𝑂(𝑛^2)          | 𝑂(1)             | Too slow; ignores the sorted property.                  |
| **Binary Search** | For each 𝑥, binary search for (𝑡𝑎𝑟𝑔𝑒𝑡 − 𝑥) in the remaining array.                                | 𝑂(𝑛log𝑛)        | 𝑂(1)             | Better, but not the most efficient for sorted arrays.   |
| **Two Pointers**  | Start pointers at `left` and `right`. Adjust based on whether current sum is too high or too low. | **𝑂(𝑛)**        | **𝑂(1)**         | **Most Optimized.** Uses the sorted property perfectly. |

4. Testing Strategy

**Standard Cases:**

- `numbers = [2, 7, 11, 15], target = 9` → `[1, 2]` (2 + 7 = 9).
- `numbers = [2, 3, 4], target = 6` → `[1, 3]` (2 + 4 = 6).

**Edge Cases (Boundaries):**

- `numbers = [-1, 0], target = -1` → `[1, 2]` (Negative numbers).
- `numbers = [5, 25, 75], target = 100` → `[2, 3]` (Solution at the very end).
- `numbers = [0, 0, 3, 4], target = 0` → `[1, 2]` (Duplicate zeros).

**Negative Cases:**

- The problem guarantees exactly one solution, so "no solution" cases don't need handling per constraints, but the logic would naturally exit the loop.

5. Optimal Code & Why (Golang)

**Why this is optimal:** The Two-Pointer technique takes advantage of the sorted array. If the `sum < target`, we _must_ move the left pointer right to get a larger value. If `sum > target`, we _must_ move the right pointer left to get a smaller value. This ensures we find the solution in one linear pass with zero extra memory allocation.

```go
func twoSum(numbers []int, target int) []int {
    // 1. Initialize two pointers at extremes
    left := 0
    right := len(numbers) - 1

    for left < right {
        currentSum := numbers[left] + numbers[right]

        if currentSum == target {
            // 2. Return 1-indexed results
            return []int{left + 1, right + 1}
        }

        if currentSum < target {
            // 3. Sum too small, move left pointer right for larger value
            left++
        } else {
            // 4. Sum too large, move right pointer left for smaller value
            right--
        }
    }

    return []int{} // Should not be reached per constraints
}
```

6. Reflection / Mistake Log

- **The 1-Index Trap:** The most common mistake is returning `[left, right]` instead of `[left+1, right+1]`. Always double-check if the problem expects 0-indexed or 1-indexed results.
- **Efficiency over Two Sum I:** While the Hash Map approach (𝑂(𝑛)time) works for unsorted arrays, using it here is "overkill" and violates the 𝑂(1) space constraint. In 2026 technical interviews, choosing Two Pointers for sorted data is the expected "signal" of an experienced developer.
- **Integer Overflow:** While not an issue in this specific LeetCode problem, in real-world 2026 systems dealing with massive numbers, `numbers[left] + numbers[right]` could overflow. If that's a risk, use `target - numbers[left] == numbers[right]` logic instead.
- **Reference:** For more on pointer patterns, see the Go standard library slices documentation.

---

## LeetCode 15: 3Sum

 1. Title & Problem Goal

- **Title:** 15. 3Sum
- **Goal:** Given an integer array `nums`, return all unique triplets `[nums[i], nums[j], nums[k]]` such that 𝑖≠𝑗,𝑖≠𝑘,𝑗≠𝑘, and their sum is zero (𝑛𝑢𝑚𝑠[𝑖]+𝑛𝑢𝑚𝑠[𝑗]+𝑛𝑢𝑚𝑠[𝑘]=0).
- **Constraint:** The solution set must **not contain duplicate triplets**.

2. Analysis & Constraints (2026 Data)

- **Target Efficiency:** For 𝑁 up to 3000, an 𝑂(𝑁^2) solution is required. 𝑂(𝑁^3) will TLE (Time Limit Exceeded).
- **The Duplicate Challenge:** This is the "hard" part of the problem. Simply finding triplets isn't enough; we must ensure we don't return `[-1, 0, 1]` twice.
- **Sorting Benefit:** Sorting the array (𝑂(𝑁log𝑁)) allows us to use **Two Pointers** and easily skip duplicate values by checking if the current number is the same as the previous one.

3. Approaches Comparison Table

| Approach                | Logic                                                                   | Time Complexity | Space Complexity | Pros/Cons                                                                  |
| ----------------------- | ----------------------------------------------------------------------- | --------------- | ---------------- | -------------------------------------------------------------------------- |
| **Brute Force**         | Three nested loops checking every combination.                          | 𝑂(𝑁^3)          | 𝑂(1)             | Way too slow; hard to handle duplicates.                                   |
| **Hash Map**            | Fix 𝑖 and 𝑗, look for −(𝑖+𝑗) in a map.                                  | 𝑂(𝑁^2)          | 𝑂(𝑁)             | Hard to manage unique triplets without a Set.                              |
| **Sort + Two Pointers** | Fix 𝑖, then use Two Pointers for 𝑗 and 𝑘 on the remaining sorted array. | **𝑂(𝑁2)**       | **𝑂(1) to 𝑂(𝑁)** | **Optimal.** Easiest way to skip duplicates and maintain 𝑂(1) extra space. |

4. Testing Strategy

**Standard Cases:**

- `nums = [-1, 0, 1, 2, -1, -4]` → `[[-1, -1, 2], [-1, 0, 1]]`.
- `nums = [0, 1, 1]` → `[]`.

**Edge Cases (Boundaries):**

- `nums = [0, 0, 0]` → `[[0, 0, 0]]` (Correctly handling identical values).
- `nums = [1, 2, -3]` (Single valid triplet) → `[[1, 2, -3]]`.
- `nums = []` or `nums = [0]` → `[]`.

**Negative Cases:**

- `nums = [1, 1, 1]` → `[]` (Sum is not zero).
- Input with many duplicates to test the skip logic.

5. Optimal Code & Why (Golang)

**Why this is optimal:** Sorting allows us to turn the problem into multiple "Two Sum II" problems. By skipping identical values for the fixed element and the pointers, we handle the "unique triplets" requirement without needing a memory-heavy `Set`.

```go
func threeSum(nums []int) [][]int { // Returning [][]int
 sort.Ints(nums)
 res := [][]int{}

 for i := 0; i < len(nums)-2; i++ {
  // 1. Skip duplicates for the first element
  if i > 0 && nums[i] == nums[i-1] {
   continue
  }

  // 2. Standard Two-Pointer approach
  l, r := i+1, len(nums)-1
  for l < r {
   sum := nums[i] + nums[l] + nums[r]
   if sum < 0 {
    l++
   } else if sum > 0 {
    r--
   } else {
    res = append(res, []int{nums[i], nums[l], nums[r]})
    // 3. Skip duplicates for left and right pointers
    for l < r && nums[l] == nums[l+1] {
     l++
    }
    for l < r && nums[r] == nums[r-1] {
     r--
    }
    l++
    r--
   }
  }
 }
 return res
}
```

6. Reflection / Mistake Log

- **The "i > 0" Check:** Forgetting `i > 0` in the duplicate check (`if nums[i] == nums[i-1]`) can lead to out-of-bounds errors or skipping the very first valid triplet.
- **Pointer Update Order:** When a sum of zero is found, you **must** update both pointers after skipping their respective duplicates. If you only update one, the next iteration will just find the same triplet (if you didn't skip) or be forced to move the other anyway.
- **The Zero Optimization:** If `nums[i] > 0` in a sorted array, you can `break` the loop immediately because no three numbers to the right can ever sum to zero (they are all positive).
- **Reference:** This logic is a staple for **systematic array manipulation** in 2026 technical assessments.

---

## LeetCode 11: Container With Most Water

 1. Title & Problem Goal

- **Title:** 11. Container With Most Water
- **Goal:** Given an integer array `height` where each element represents the height of a vertical line, find two lines that together with the x-axis form a container, such that the container contains the most water.
- **Formula:** 𝐴𝑟𝑒𝑎=min(ℎ𝑒𝑖𝑔ℎ𝑡[𝑖],ℎ𝑒𝑖𝑔ℎ𝑡[𝑗])×(𝑗−𝑖).

2. Analysis & Constraints (2026 Data)

- **Input Size (𝑛):** Up to 10^5.
  - An 𝑂(𝑛^2) solution (checking every pair) will reach 10^10 operations and **Time Limit Exceeded (TLE)**.
  - Target Complexity: **𝑂(𝑛)** using a greedy two-pointer approach.
- **Constraint:** You cannot slant the container; it must be rectangular.
- **Observation:** The width of the container is always decreasing as we move pointers inward. To find a larger area, we must find a significantly taller line to compensate for the lost width.

1. Approaches Comparison Table

| Approach                   | Logic                                                                        | Time Complexity | Space Complexity | Pros/Cons                                                   |
| -------------------------- | ---------------------------------------------------------------------------- | --------------- | ---------------- | ----------------------------------------------------------- |
| **Brute Force**            | Nested loops check every possible pair of lines.                             | 𝑂(𝑛2)           | 𝑂(1)             | Simple but unusable for large 𝑛                             |
| **Two Pointers (Optimal)** | Start at extremes. Always move the pointer pointing to the **shorter** line. | **𝑂(𝑛)**        | **𝑂(1)**         | **Most Optimized.** Guarantees finding the max in one pass. |

4. Testing Strategy

**Standard Cases:**

- `height = [1,8,6,2,5,4,8,3,7]` → `49` (Between 8 and 7, width 7: min(8,7)×7=49).
- `height = [1,1]` → `1`.

**Edge Cases (Boundaries):**

- `height = [1, 100, 100, 1]` (Tall narrow container vs. short wide) → `100`.
- `height = [1, 2, 3, 4, 5]` (Strictly increasing) → `6` (Between 2 and 5).
- `height = [5, 4, 3, 2, 1]` (Strictly decreasing).

**Negative Cases:**

- Array with only two elements (Minimum size).
- Array where all heights are the same: `[5, 5, 5]` → `10`.

5. Optimal Code & Why (Golang)

**Why this is optimal:** The logic is **Greedy**. We start with the maximum possible width. To potentially find a larger area, we must replace the shorter side, because the area is limited by the shorter side. Moving the taller side would only decrease width without increasing the bottleneck height.

```go
func maxArea(height []int) int {
    maxArea := 0
    left := 0
    right := len(height) - 1

    for left < right {
        // 1. Calculate current area
        w := right - left
        h := 0
        if height[left] < height[right] {
            h = height[left]
        } else {
            h = height[right]
        }

        currentArea := w * h

        // 2. Update global max
        if currentArea > maxArea {
            maxArea = currentArea
        }

        // 3. Move the pointer pointing to the shorter line
        // This is the greedy step to find a taller bottleneck
        if height[left] < height[right] {
            left++
        } else {
            right--
        }
    }

    return maxArea
}
```

6. Reflection / Mistake Log

- **The "Move Shorter" Logic:** Initially, it feels counter-intuitive to move the side that "defines" the area, but mathematically, moving the taller side _cannot_ increase the area (it only keeps the same or smaller height while decreasing width).
- **Off-by-one:** Width is `right - left`, not `right - left + 1`. This is because we are measuring intervals between lines, not the number of lines themselves.
- **Wait, what about equal heights?** If `height[left] == height[right]`, it doesn't matter which one you move; both will lead to the same outcome in terms of searching for a better result.
- **Performance:** For 2026 Go development, avoiding the `math.Min` and `math.Max` functions and using simple `if/else` statements is slightly faster as it avoids interface overhead and float conversions. Reference Go Performance.

---

## LeetCode 42: Trapping Rain Water

 1. Title & Problem Goal

- **Title:** 42. Trapping Rain Water
- **Goal:** Given 𝑛 non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it can trap after raining.
- **Core Logic:** The water trapped at any index 𝑖 is determined by min(max_left,max_right)−height[𝑖].

2. Analysis & Constraints (2026 Data)

- **Input Size (𝑛):** Up to 2×10^4.
  - 𝑂(𝑛^2) is too slow. We need**𝑂(𝑛)**.
- **Constraints:** `height[i] >= 0`. No negative heights.
- **Target Efficiency:** The most advanced solutions use **Two Pointers** to achieve 𝑂(1) extra space, as it avoids storing auxiliary arrays for left/right maximums.

3. Approaches Comparison Table

| Approach                   | Logic                                                                       | Time Complexity | Space Complexity | Pros/Cons                                                   |
| -------------------------- | --------------------------------------------------------------------------- | --------------- | ---------------- | ----------------------------------------------------------- |
| **Brute Force**            | For each bar, scan left and right to find max heights.                      | 𝑂(𝑛^2)          | 𝑂(1)             | Simple but hits TLE.                                        |
| **Dynamic Programming**    | Pre-compute `leftMax` and `rightMax` arrays.                                | 𝑂(𝑛)            | 𝑂(𝑛)             | Very easy to understand; uses extra memory.                 |
| **Two Pointers (Optimal)** | Move pointers from both ends; maintain `leftMax` and `rightMax` on the fly. | **𝑂(𝑛)**        | **𝑂(1)**         | **Most Optimized.** Best for high-performance 2026 systems. |
| **Monotonic Stack**        | Use a stack to track bounded "basins" as you iterate.                       | 𝑂(𝑛)            | 𝑂(𝑛)             | Useful for similar "area" problems; harder to visualize.    |

4. Testing Strategy

**Standard Cases:**

- `height = [0,1,0,2,1,0,1,3,2,1,2,1]` → `6`.
- `height = [4,2,0,3,2,5]` → `9`.

**Edge Cases (Boundaries):**

- `height = [1, 2, 3, 4, 5]` (Strictly increasing) → `0`.
- `height = [5, 4, 3, 2, 1]` (Strictly decreasing) → `0`.
- `height = [1]` or `[]` (Small input) → `0`.

**Negative Cases:**

- `height = [5, 5, 5]` (Flat surface) → `0`.
- `height = [2, 0, 2]` (Simple basin) → `2`.

5. Optimal Code & Why (Golang)

**Why this is optimal:** The Two-Pointer approach eliminates the need for auxiliary arrays. By always moving the pointer with the **smaller** maximum height, we can guarantee that the water trapped at that position is limited by that smaller maximum, regardless of what lies between the two pointers.

```go
func trap(height []int) int {
 if len(height) == 0 {
  return 0
 }

 left, right := 0, len(height)-1
 leftMax, rightMax := height[left], height[right]
 totalWater := 0

 for left < right {
  // We can only trap water based on the shorter side
  if leftMax < rightMax {
   left++
   // Update leftMax
   if height[left] > leftMax {
    leftMax = height[left]
   } else {
    // Trapped water = boundary - current height
    totalWater += leftMax - height[left]
   }
  } else {
   right--
   // Update rightMax
   if height[right] > rightMax {
    rightMax = height[right]
   } else {
    totalWater += rightMax - height[right]
   }
  }
 }

 return totalWater
}
```

6. Reflection / Mistake Log

- **The "Why it works" logic:** The fundamental "aha!" moment for the 𝑂(1) space solution is realizing that if `leftMax < rightMax`, the amount of water trapped at the `left` pointer is strictly dependent on `leftMax`, even if there is an even taller peak somewhere in the middle.
- **Updating Max vs. Calculating Water:** Ensure you update the `max` variable **before** calculating the water for that specific index. If the current height is the new maximum, zero water is trapped there.
- **Go Performance:** In 2026, manual loops with two pointers are significantly more cache-friendly than creating multiple slices/arrays, making this the preferred approach for high-concurrency Go backend services.
- **Visualizing:** Think of it as "filling the bucket" from the lower side. The lower wall always determines the water level.

---
