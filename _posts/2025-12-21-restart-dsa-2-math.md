---
layout: post
title: "(Re)Start Learning Data Structure and Algorithm - Part 2, Mathematics"
date: 2025-12-21
categories: [dsa]
tags: [software engineer]
author: Batiar
---

To implement Data Structure and Algorithm, we must evaluate how efficient and effective of different algorithms using math

here is some common math guide that i learn from <https://www.geeksforgeeks.org/dsa/maths-for-data-structure-and-algorithms-dsa-a-complete-guide/>.

- [[#GCD / HCF (Euclian's Algorithm)]]
- [[#Divisors of a number]]
- [[#Prime Numbers & The Sieve of Eratosthenes]]
- [[#Square Root]]
- [[#Modular Arithmetic]]
- [[#Fast Power-Exponentiation by Squaring]]
- [[#Factorial of a number]]
- [[#Fibonacci Number]]
- [[#Catalan Numbers]]
- [[#Euler Totient Function]]
- [[#Prime numbers & Primality Tests]]
- [[#Prime Factorization & Divisors]]
- [[#Chinese Remainder Theorem]]

---

## GCD / HCF (Euclian's Algorithm)

**Greatest Common Divisor (GCD)** and **Least Common Multiple (LCM)** are fundamental tools for finding relationships between numbers, while the **Euclidean Algorithm** is the most efficient way to compute them.

### Key Concepts and Facts

- **GCD (Greatest Common Divisor)**: The largest positive integer that divides two or more integers without leaving a remainder.
- **LCM (Least Common Multiple)**: The smallest positive integer that is divisible by both integers.
- **Fundamental Relationship**: For any two positive integers a and b $$LCM(a,b)=|a×b|/GCD(a,b)$$
- **Euclidean Efficiency**: Unlike prime factorization, which is slow for large numbers, the Euclidean Algorithm runs in logarithmic time $(O(log(min(a,b)))$

### Example: GCD and LCM of 12 and 33

1. **GCD**: $$GCD(33,12)→33÷12=2$$
   Remainder 9→12÷9=1
   Remainder 3→9÷3=3
   Remainder 0
   The last non-zero remainder is **3**.
2. **LCM**: $$12×333=3963=𝟏𝟑𝟐$$

### How to Calculate (Euclidean Algorithm)

1. Divide the larger number by the smaller number to find the remainder.
2. Replace the larger number with the smaller number and the smaller number with the remainder.
3. Repeat until the remainder is zero.
4. The final non-zero value is the **GCD**.

### Golang Code

This implementation provides both iterative and recursive GCD functions, plus an LCM function based on their mathematical relationship.

```go
package main

import "fmt"

// GCD calculates the Greatest Common Divisor using the iterative Euclidean Algorithm
func GCD(a, b int) int {
 for b != 0 {
  a, b = b, a % b
 }
 return a
}

// LCM calculates the Least Common Multiple using the GCD relationship
func LCM(a, b int) int {
 if a == 0 || b == 0 {
  return 0
 }
 // We divide before multiplying to prevent potential integer overflow
 return (a / GCD(a, b)) * b
}

func main() {
 a, b := 12, 33
 fmt.Printf("GCD(%d, %d) = %d\n", a, b, GCD(a, b))
 fmt.Printf("LCM(%d, %d) = %d\n", a, b, LCM(a, b))
}
```

### Real Use Cases

- **Cryptography**: GCD is vital for **RSA encryption** to ensure certain key values are co-prime (GCD of 1).
- **Scheduling**: LCM determines when recurring events (like periodic backups or hardware cycles) will happen at the same time.
- **Fraction Simplification**: GCD is used to reduce fractions (e.g., $4 / 8$ becomes $1/2$ by dividing both by GCD = 4
- **Network Synchronization**: GCD helps find common sampling rates for audio/video synchronization across different devices.
- **Resource Allocation**: GCD helps in dividing work or materials into equal parts without leftovers.

---

## Divisors of a number

### Key Concepts and Facts

- **Factor**: The terms "divisor" and "factor" are often used interchangeably in math.
- **Dividend**: The number being divided (e.g., 12 in 12 ÷ 3).
- **Quotient**: The result of the division (e.g., 4 in 12 ÷ 3).
- **Fundamental Bounds**: Every integer $n > 1$ has at least two divisor: 1 and n itself.
- **Proper Divisors**: These are all divisors of a number _except_ the number itself.
- **Symmetry Rule**: Divisors always occur in pairs $(a, b)$ such that $a*b = n$. If a is a divisor, then $n/a$ is also a divisor.
- **Square Root Property**: If you check all numbers from 1 up to $\sqrt{n}$, you will find every divisor pair. For Example, if n = 36, the largest number you need to test is $\sqrt{36} = 6$.

### Example: Divisors of 12

1. Test 1: $12 / 1 = 12$ (Pair: 1,12)
2. Test 2: $12 / 2 = 6$ (Pair: 2,6)
3. Test 3 $12 / 1 = 12$ (Pair: 3,4)
4. Test 4: $12 / 1 = 12$ (Pair: 4,3 already found on test 3)

**List of Divisors**: 1, 2, 3, 4, 6, 12.

### How To Calculate

1. Iterate from $i = 1$ to $\sqrt{n}$
2. Check if $n \mod i == 0$
3. if it is, add i to list
4. if $i != n/i$ add the partner n/i to list (to prevent duplicate $6x6 = 36$)

### Golang Code

This implementation uses the optimal $O(\sqrt{n})$ approach

```go
package main

import (
 "fmt"
 "math"
)

func main() {
 num := 36
 fmt.Printf("Divisors of %d: %v\n", num, findDivisors(num))
}

func findDivisors(n int) []int {
 var divisors []int
 limit := int(math.Sqrt(float64(n)))

 for i := 1; i <= limit; i++ {
  if n%i == 0 {
   divisors = append(divisors, i)
   // Add partner divisor if it's not the same (e.g., 6 for 36)
   if i != n/i {
    divisors = append(divisors, n/i)
   }
  }
 }
 return divisors
}
```

### Real Use Cases

- **Cryptography**: Modern encryption like RSA relies on the difficulty of finding divisors (prime factors) for extremely large numbers.
- **Financial Calculations**: Used to calculate loan repayments, interest rates, and annuities.
- **Engineering**: Determining load distributions and stresses in structural designs often requires understanding how values can be subdivided.
- **Data Packaging**: Determining optimal grid dimensions for displaying images or icons (e.g., finding pairs of divisors to fit a certain number of items into a rectangle).

---

## Prime Numbers & The Sieve of Eratosthenes

A **Prime Number** is a natural number greater than 1 that has no positive divisors other than 1 and itself. The **Sieve of Eratosthenes** is one of the most efficient ways to find all primes up to a specific limit n

### Key Concepts and Facts

- **Composite Numbers**: Any number greater than 1 that is not prime (it has more than two divisors).
- **The Sieve Logic**: Instead of checking if each number is prime (primality testing), we start with 2 and **mark all of its multiples as composite**. We then move to the next unmarked number and repeat.
- **Efficiency**: The Sieve has a time complexity of $𝑂(𝑛 log log 𝑛)$, which is significantly faster than checking every number individually $𝑂(𝑛√n)$
- **Optimization**: You only need to iterate up to $\sqrt{n}$. if a number m is composite, it must have a factor less than or equal to its square root.

### Example: Finding Primes up to 20

1. **List numbers**: 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20.
2. **Start with 2**: Mark all multiples of 2 (4, 6, 8, 10, 12, 14, 16, 18, 20) as composite.
3. **Move to 3**: Mark all multiples of 3 (9, 12, 15, 18) as composite.
4. **Move to 5**: Since $5^2 = 25$ is greater than 20, we stop
5. **Result**: The unmarked numbers are **2, 3, 5, 7, 11, 13, 17, 19**.

### How To Calculate

1. Create a boolean array of size $n + 1$ and initialize all entries as true (assume all are prime)
2. Set indices `0` and `1` to `false`.
3. For p = 2 to $\sqrt{n}$
   1. if array[p] is true, then it is a prime
   2. mark all multiple of p starting $p^2$ as false
4. All remaining `true` indices are your prime numbers.

### Golang Code

```go
package main

import (
 "fmt"
 "math"
)

// SieveOfEratosthenes returns a slice of all primes up to n
func SieveOfEratosthenes(n int) []int {
 // Create a boolean array "isPrime[0..n]"
 isPrime := make([]bool, n+1)
 for i := 2; i <= n; i++ {
  isPrime[i] = true
 }

 sqrtN := int(math.Sqrt(float64(n)))

 for p := 2; p <= sqrtN; p++ {
  // If isPrime[p] is not changed, then it is a prime
  if isPrime[p] {
   // Update all multiples of p starting from p*p
   for i := p * p; i <= n; i += p {
    isPrime[i] = false
   }
  }
 }

 // Collect all prime numbers
 var primes []int
 for p := 2; p <= n; p++ {
  if isPrime[p] {
   primes = append(primes, p)
  }
 }
 return primes
}

func main() {
 limit := 50
 fmt.Printf("Primes up to %d: %v\n", limit, SieveOfEratosthenes(limit))
}
```

### Real Use Cases

- **Cryptography**: Prime numbers are the building blocks of RSA Encryption, where large primes are multiplied to create public keys.
- **Hash Tables**: Using prime numbers for the size of hash tables helps reduce "collisions" (when two different pieces of data want the same slot).
- **Random Number Generation**: Primes are used in linear congruential generators to ensure a long period before the random sequence repeats.
- **Cicada Survival**: In nature, certain species of cicadas emerge in 13 or 17-year cycles (both primes) to minimize the chance of their life cycles coinciding with the population peaks of predators.

---

## Square Root

The **Square Root** of a number 𝑥 is a value 𝑦 such that $𝑦^2=𝑥$. It is the inverse operation of squaring a number.

### Key Concepts and Facts

- **Radical Symbol**: Denoted by the symbol √x .
- **Principal Square Root**: While $(-3)^2$ and $3^2$ both equal 9, the symbol $\sqrt{9}$ refers to specifically to the positive result (3)
- **Perfect Squares**: Integers whose square roots are also integers (e.g., 1, 4, 9, 16, 25).
- **Irrationality**: The square root of any non-perfect square (like $\sqrt{2}$ is an irrational number, meaning its decimals go on forever without repeating.
- **Negative Numbers**: In the set of Real Numbers, you cannot take the square root of a negative number. This requires **Complex Numbers** (represented as i)

## Example

- **Perfect Square**: $\sqrt{64}$ = 8
- **Non-Perfect Square**: $\sqrt{20}$ +-4.472
- **Property**: $\sqrt{a * b}$ = $\sqrt{a} * \sqrt{b}$

### How To Calculate

For computer science, the two most common ways to calculate a square root without using a built-in library are:

1. **Binary Search (for integers)**: If you need the integer floor of a square root, you can binary search between 1 and n
2. **Newton's Method (Newton-Raphson)**: An iterative approach that produces highly accurate floating-point results.
   $$ nextGuess = 1\div{2}(guess + (n\div{guess}))$$

### Golang Code and Complexities

Below is an implementation of **Newton's Method**, which is how many low-level standard libraries (like Go's `math.Sqrt`) are conceptually built.

```go
package main

import (
 "fmt"
 "math"
)

func SqrtOptimal(n float64) float64 {
 if n < 0 { return math.NaN() }
 if n == 0 { return 0 }

 // A better initial guess helps convergence for huge numbers
 z := n / 2.0

 for {
  nextZ := 0.5 * (z + n/z)

  // Exit condition: stop when the value stops changing
  // This handles the precision limits of float64 automatically
  if z == nextZ {
   break
  }
  z = nextZ
 }
 return z
}

func main() {
 // Testing with a very large number
 bigNum := 1e100
 fmt.Printf("Sqrt of 1e100: %e\n", SqrtOptimal(bigNum))
 fmt.Printf("Math library:   %e\n", math.Sqrt(bigNum))
}
```

**Complexities**

- **Time Complexity**:
  - **Binary Search**: 𝑂(log𝑛)
    - **Newton's Method**: $𝑂(log(log(𝑛/𝜖)))$ , where 𝜖 is the desired precision. It converges quadratically, making it extremely fast.
- **Space Complexity**: 𝑂(1), as it only requires a few variables for iteration.

### Real Use Cases

- **Geometry and Physics**: Calculating the distance between two points in 2D or 3D space using the Pythagorean Theorem (
- **Statistics**: Calculating **Standard Deviation**, which is the square root of Variance, to understand data volatility.
- **Graphics and Games**: Normalizing vectors (making them length 1) for lighting and movement calculations.
- **Machine Learning**: Used in algorithms like **RMSProp** or calculating **Euclidean distance** for K-Nearest Neighbors (KNN).
- **Finance**: Calculating the Sharpe Ratio, which involves the square root of time to annualize volatility.

---

## Modular Arithmetic

"The "Clock" Mathematics" Modular arithmetic is a system of arithmetic for integers where numbers "wrap around" upon reaching a certain value, called the **modulus**.

---

### Key Concepts and Facts

- **The Modulus (𝑚)**: The value at which the numbers wrap around.
- **Congruence**: Two numbers 𝑎 and 𝑏 are congruent modulo 𝑚. if their difference (𝑎−𝑏) is an integer multiple of 𝑚
  - _Notation_: 𝑎≡𝑏(mod𝑚)
- **The Remainder Property**: 𝑎(mod𝑚) always results in a value between 0 and 𝑚−1
- **Properties**:
  - **Addition**: (𝑎+𝑏)(mod𝑚)=((𝑎(mod𝑚))+(𝑏(mod𝑚)))(mod𝑚)
  - **Multiplication**: (𝑎×𝑏)(mod𝑚)=((𝑎(mod𝑚))×(𝑏(mod𝑚)))(mod𝑚)
  - **Division**: Division is not straightforward; it requires finding the **Modular Multiplicative Inverse**.

### Example: The 12-Hour Clock

The most common example of modular arithmetic is the clock (Modulo 12).

- If it is **9:00** now, what time will it be in **5 hours**?
- 9+5=14
- 14(mod12)=2
- **Result**: 2:00.

### How To Calculate

1. **Divide** the number 𝑎 by the modulus 𝑚
2. **Find the remainder** (ignore the quotient).
3. **Handling Negatives**: In mathematics, −1(mod5) is 4. However, in many programming languages (including Go), the `%` operator can return a negative result. To ensure a positive result:
   - `((a % m) + m) % m`

### Golang Code and Complexities

Go uses the `%` operator for remainder. This example includes a "Standard Modulo" function to correctly handle negative inputs.

```go
package main

import "fmt"

// Modulo returns the positive remainder of a / m
func Modulo(a, m int) int {
 return ((a % m) + m) % m
}

// ModularExponentiation calculates (base^exp) % mod efficiently
func ModularExponentiation(base, exp, mod int) int {
 res := 1
 base = base % mod
 for exp > 0 {
  if exp%2 == 1 {
   res = (res * base) % mod
  }
  base = (base * base) % mod
  exp = exp / 2
 }
 return res
}

func main() {
 // Simple Modulo
 fmt.Printf("-1 mod 5 = %d\n", Modulo(-1, 5)) // Output: 4

 // Modular Exponentiation: (5^3) % 7
 // 125 % 7 = 6
 fmt.Printf("5^3 mod 7 = %d\n", ModularExponentiation(5, 3, 7))
}
```

**Complexities**

- **Basic Modulo (`%`)**: 𝑂(1) for fixed-size integers.
- **Modular Exponentiation**: 𝑂(logexp). This is crucial because 𝑏𝑎𝑠𝑒𝑒𝑥𝑝 can be a number with thousands of digits, but modular exponentiation keeps the numbers small throughout the process.
- **Space**: 𝑂(1)

### Real Use Cases

- **Cryptography (RSA/Diffie-Hellman)**: These protocols rely on the fact that modular exponentiation is easy to compute, but its inverse (Discrete Logarithm Problem) is extremely difficult.
- **Hashing**: Hash functions (like SHA-256) use modular arithmetic to ensure the resulting hash fits within a fixed number of bits.
- **Cyclic Data Structures**: Using `%` to wrap an index around in a **Circular Queue** or **Ring Buffer**.
- **Calendar Algorithms**: Determining the day of the week (e.g., Zeller's congruence) uses modulo 7.
- **Load Balancing**: Distributing requests across 𝑁 servers using `RequestID % N`.

---

## Fast Power-Exponentiation by Squaring

**Exponentiation by Squaring** is an efficient algorithm for computing the power of a number. While a naive loop takes 𝑂(𝑛) time to compute $x^n$, this method reduces the complexity to 𝑂(log𝑛).

### Key Concepts and Fact

- **Divide and Conquer**: The algorithm breaks the problem into smaller sub-problems by halving the exponent at each step.
- **Even Exponents**: $$x^n=(x^2)n/2$$
- **Odd Exponents**:$$x^n=x * (x^2)^{(n-1)/2}$$
- **Efficiency**: To calculate $2^{100}$, a naive approach performs 100 multiplications; Fast Power performs only **7**.

---

### Example: Calculating $3^{13}$

The exponent 13 in binary is `1101` (8+4+1).

1. $3^1$
2. $3^2=9$
3. $3^4=81$
4. $3^8=6561$
5. **Result**: 313=38×34×31=6561×81×3=𝟏,𝟓𝟗𝟒,𝟑𝟐𝟑

### How To Calculate

The algorithm can be implemented **recursively** or **iteratively** (often preferred for performance):

1. Start with `result = 1`.
2. While the exponent 𝑛>0 :
   - If 𝑛 is **odd**, multiply `result` by the current `base`.
   - Square the `base` (𝑏𝑎𝑠𝑒=𝑏𝑎𝑠𝑒×𝑏𝑎𝑠𝑒).
   - Divide 𝑛 by 2 (integer division).
3. Return `result`.

### Golang Code and Complexities

This implementation includes the iterative version, which is the most common in 2025 production environments.

```go
package main

import "fmt"

// FastPower computes base^exp using Exponentiation by Squaring
func FastPower(base, exp int) int {
 res := 1
 for exp > 0 {
  // If exponent is odd, multiply result by current base
  if exp%2 == 1 {
   res *= base
  }
  // Square the base
  base *= base
  // Divide exponent by 2
  exp /= 2
 }
 return res
}

func main() {
 base, exp := 3, 13
 fmt.Printf("%d^%d = %d\n", base, exp, FastPower(base, exp))
}
```

**Complexities**

- **Time Complexity**: 𝑂(log𝑛)
  , where 𝑛 is the exponent.
- **Space Complexity**: 𝑂(1) for iterative; 𝑂(log𝑛) for recursive due to the call stack.

### Real Use Cases

- **Cryptography**: This is the engine behind **RSA** and **Diffie-Hellman** key exchanges. In 2025, these protocols use massive exponents (e.g., 2048-bit numbers) that would be impossible to calculate without this algorithm.
- **Modular Exponentiation**: In competitive programming and security, calculating (𝑏𝑎𝑠𝑒𝑒𝑥𝑝)(mod𝑚𝑜𝑑) is done using this method to keep numbers within register limits.
- **Matrix Exponentiation**: Used to find the 𝑛𝑡ℎ term of linear recurrence relations (like the **Fibonacci sequence**) in 𝑂(log𝑛) time.
- **Computer Graphics**: Used in geometric transformations and scaling operations where repeated matrix multiplications are required.

## Factorial of a Number

"The Language of Nature" The **Factorial** of a non-negative integer 𝑛 (denoted as 𝑛! ) is the product of all positive integers less than or equal to 𝑛.

### Key Concepts and Facts

- **Definition**: 𝑛!=𝑛×(𝑛−1)×(𝑛−2)×…×1.
- **Zero Factorial**: By convention and mathematical consistency,**0!=1**.
- **Growth Rate**: Factorials grow extremely fast (faster than exponential functions). 20! is the largest factorial that fits in a standard 64-bit integer.
- **Recursive Nature**: A factorial can be defined in terms of itself: 𝑛!=𝑛×(𝑛−1)!.

### Example: Calculating 5

- 5!=5×4×3×2×1
- 5×4=20
- 20×3=60
- 60×2=120
- 120×1=120
- **Result**: 5!=120

### How To Calculate

1. **Iterative Method**: Use a loop to multiply numbers from 1 to 𝑛.
2. **Recursive Method**: Call a function 𝑓(𝑛) that returns 𝑛×𝑓(𝑛−1) until it reaches the base case 𝑓(0)=1.
3. **Large Numbers**: For 𝑛>20, use arbitrary-precision libraries (like `math/big` in Go) to prevent integer overflow.

### Golang Code and Complexities

This example provides an iterative approach for standard integers and a "Big" version for 2025-standard high-precision needs.

```go
package main

import (
 "fmt"
 "math/big"
)

// FactorialIterative handles numbers up to 20
func FactorialIterative(n int) uint64 {
 if n < 0 { return 0 }
 var res uint64 = 1
 for i := 2; i <= n; i++ {
  res *= uint64(i)
 }
 return res
}

// FactorialBig handles very large numbers (n > 20)
func FactorialBig(n int64) *big.Int {
 res := big.NewInt(1)
 for i := int64(2); i <= n; i++ {
  res.Mul(res, big.NewInt(i))
 }
 return res
}

func main() {
 fmt.Printf("5! = %d\n", FactorialIterative(5))

 // Example of a large factorial (50!)
 fmt.Printf("50! = %s\n", FactorialBig(50).String())
}
```

**Complexities**

- **Time Complexity**: 𝑂(𝑛) because it requires 𝑛 multiplications.
- **Space Complexity**:
  - **Iterative**: 𝑂(1) (constant space).
  - **Recursive**: 𝑂(𝑛) (due to call stack depth).

### Real Use Cases

- **Combinatorics**: Used to calculate permutations and combinations (e.g., "How many ways can 10 people sit in 10 chairs?").
- **Probability**: The basis for the **Binomial Distribution** and calculating the odds of complex events.
- **Taylor Series**: Used in calculus to approximate functions like sin(𝑥), cos(𝑥), and 𝑒𝑥.
- **Algorithm Analysis**: Measuring the complexity of problems like the **Traveling Salesperson Problem**, which is 𝑂(𝑛!).
- **Data Science**: Used in Gamma Distributions which generalize factorials to non-integer values.

---

## Fibonacci Number

The **Fibonacci sequence** is a series of numbers where each number is the sum of the two preceding ones, usually starting with **0** and **1**.

### Key Concepts and Facts

- **Recurrence Relation**: 𝐹(𝑛)=𝐹(𝑛−1)+𝐹(𝑛−2) for 𝑛>1.
- **Base Cases**: 𝐹(0)=0,𝐹(1)=1.
- **The Golden Ratio**: As 𝑛 increases, the ratio of 𝐹(𝑛)𝐹(𝑛−1) approaches approximately **1.618** (𝜙), known as the Golden Ratio.
- **Binet's Formula**: You can find the 𝑛𝑡ℎ Fibonacci number directly using: $$F(n) = \phi^n - (-\phi)^{-n}\div \sqrt{5}$$
- **Growth**: The sequence grows exponentially.

### Example: The First 10 Numbers

Starting from 0 and 1:

1. 0+1=𝟏
2. 1+1=𝟐
3. 1+2=𝟑
4. 2+3=𝟓
5. 3+5=𝟖
6. 5+8=𝟏𝟑
7. 8+13=𝟐𝟏
8. 13+21=𝟑𝟒

- **Sequence**: 0, 1, 1, 2, 3, 5, 8, 13, 21, 34...

### How To Calculate

1. **Naive Recursion**: Simple to write but extremely slow for large 𝑛 (𝑂(2𝑛)).
2. **Iterative (Dynamic Programming)**: Start from the bottom up. Store only the last two numbers to save space.
3. **Matrix Exponentiation**: Use Fast Power logic with matrices to solve in 𝑂(log𝑛).

### Golang Code and Complexities

This implementation shows the **Space-Optimized Iterative** approach, which is the standard for most interviews and applications in 2025.

```go
package main

import "fmt"

// Fibonacci returns the nth Fibonacci number
func Fibonacci(n int) int {
 if n <= 1 {
  return n
 }

 // We only need to track the previous two values
 prev, current := 0, 1

 for i := 2; i <= n; i++ {
  next := prev + current
  prev = current
  current = next
 }

 return current
}

func main() {
 n := 10
 fmt.Printf("Fibonacci number at position %d is %d\n", n, Fibonacci(n))
}
```

**Complexities**

- **Time Complexity**: 𝑂(𝑛) — we visit each number up to 𝑛 exactly once.
- **Space Complexity**: 𝑂(1) — we only store two variables (`prev` and `current`) regardless of how large 𝑛 is.
  - _Note: Standard recursion is 𝑂(𝑛) space due to the call stack._

### Real Use Cases

- **Agile Development**: Fibonacci Scaling is used in "Planning Poker" for estimating the complexity of software tasks (1, 2, 3, 5, 8, 13...).
- **Financial Markets**: **Fibonacci Retracement** levels are used by traders to identify potential support and resistance areas in stock charts.
- **Computer Science Data Structures**: **Fibonacci Heaps** are used in priority queue operations and to speed up Dijkstra's Algorithm.
- **User Interface Design**: The Golden Ratio (derived from Fibonacci) is used to create aesthetically pleasing layouts and typography scales.
- **Biology**: Used to model the arrangement of leaves on a stem, the scales of a pinecone, and the flowering of an artichoke.

---

## Catalan Numbers

"The Mathematics of Structure" **Catalan Numbers** are a sequence of natural numbers that occur in various counting problems, particularly those involving recursive structures like trees, polygons, and paths.

### Key Concepts and Facts

- **The Sequence**: 1,1,2,5,14,42,132,429,1430,… (starting from 𝑛=0).
- **Definition**: The 𝑛𝑡ℎ Catalan number is defined using binomial coefficients: 𝐶𝑛=1𝑛+12𝑛𝑛=(2𝑛)!(𝑛+1)!𝑛!
- **Recurrence Relation**: 𝐶𝑛+1=𝑛𝑖=0𝐶𝑖𝐶𝑛−𝑖
- **Meaning**: They often represent the number of ways to organize or partition a structure without crossing certain bounaries.

### Example: 𝐶3 (Binary Trees)

How many ways can you arrange 3 nodes into a binary search tree?

1. Root with 0 left, 2 right nodes (𝐶0×𝐶2=1×2=2)
2. Root with 1 left, 1 right node (𝐶1×𝐶1=1×1=1)
3. Root with 2 left, 0 right nodes (𝐶2×𝐶0=2×1=2)

- **Total**: 2+1+2=𝟓  
   . Thus,𝐶3=5.

### How To Calculate

1. **Direct Formula**: Use factorials (prone to overflow).
2. **Binomial Coefficient**: $𝐶𝑛=(2𝑛\div𝑛)−(2𝑛\div𝑛−1$).
3. **Iterative (Optimal for Coding)**: Calculate 𝐶𝑛 from 𝐶𝑛−1 using the multiplier: $𝐶𝑛=𝐶𝑛−1×2(2𝑛−1)\div𝑛+1$

### Golang Code and Complexities

This implementation uses the iterative multiplier method to prevent early overflow while maintaining high performance.

```go
package main

import "fmt"

// CatalanNumber returns the nth Catalan number
func CatalanNumber(n int) uint64 {
 if n <= 1 {
  return 1
 }

 // Using the formula: C(n) = C(n-1) * (4n - 2) / (n + 1)
 var res uint64 = 1
 for i := 1; i <= n; i++ {
  res = res * uint64(2*(2*i-1)) / uint64(i+1)
 }
 return res
}

func main() {
 for i := 0; i <= 10; i++ {
  fmt.Printf("C%d: %d\n", i, CatalanNumber(i))
 }
}
```

**Complexities**

- **Time Complexity**: 𝑂(𝑛) — a single loop calculates the value.
- **Space Complexity**: 𝑂(1) — only one variable is used to store the running product.
- **Note**: For 𝑛>30, `uint64` will overflow; use `math/big` for larger indices.

### Real Use Cases

- **Computer Science (Trees)**: Calculating the number of unique **Binary Search Trees (BST)** that can be formed with 𝑛 keys.
- **Data Parsing**: Determining the number of ways 𝑛 pairs of **balanced parentheses** can be arranged (e.g., `((()))`, `()()()`, `(())()`, etc.).
- **Polygon Triangulation**: The number of ways a convex polygon with 𝑛+2 sides can be cut into triangles.
- **Pathfinding (Dyck Paths)**: Counting the number of paths from (0,0) to (𝑛,𝑛) that do not cross the diagonal line 𝑦=𝑥.
- **Stack Sorting**: Calculating the number of permutations of {1,…,𝑛} that can be sorted using a single stack.

---

## Euler Totient Function

𝜙(𝑛) **Euler's Totient Function**, denoted as 𝜙(𝑛) (phi), counts the number of positive integers up to 𝑛 that are **relatively prime** (co-prime) to 𝑛. Two numbers are co-prime if their Greatest Common Divisor (GCD) is 1.

### Key Concepts and Facts

- **Co-prime Definition**: gcd(𝑎,𝑛)=1.
- **Prime Numbers**: If 𝑝 is prime, then 𝜙(𝑝)=𝑝−1 (because every number smaller than a prime is co-prime to it).
- **Multiplicative Property**: If gcd(𝑎,𝑏)=1, then 𝜙(𝑎×𝑏)=𝜙(𝑎)×𝜙(𝑏) .
- **Euler's Product Formula**: 𝜙(𝑛)=𝑛𝑝|𝑛(1−1𝑝) _where the product is over distinct prime factors 𝑝 of 𝑛._

### Example: 𝜙(12)

1. List numbers up to 12: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12.
2. Check gcd(𝑖,12):
   - gcd(1,12)=1 (Yes)
   - gcd(5,12)=1 (Yes)
   - gcd(7,12)=1 (Yes)
   - gcd(11,12)=1 (Yes)
3. **Result**: There are **4** such numbers {1,5,7,11}. So, 𝜙(12)=4.

### How To Calculate

The most efficient way to compute 𝜙(𝑛) is using the prime factorization method:

1. Start with `result = n`.
2. Iterate through prime factors 𝑝 of 𝑛 (starting from 2 up to 𝑛√).
3. If 𝑝 divides 𝑛:
   - Update `result = result * (1 - 1/p)` which is equivalent to `result -= result / p`.
   - Divide 𝑛 by 𝑝 repeatedly to remove all occurrences of that prime.
4. If 𝑛>1 at the end, it means the remaining 𝑛 is prime; apply the formula one last time.

### Golang Code and Complexities

```go
package main

import "fmt"

// EulersTotient calculates phi(n) in O(sqrt(n)) time
func EulersTotient(n int) int {
 result := n

 // Check prime factors from 2 up to sqrt(n)
 for i := 2; i*i <= n; i++ {
  if n%i == 0 {
   // Update result using the formula: res = res * (1 - 1/p)
   result -= result / i

   // Remove all occurrences of factor i
   for n%i == 0 {
    n /= i
   }
  }
 }

 // If n > 1, the remaining n is a prime factor
 if n > 1 {
  result -= result / n
 }

 return result
}

func main() {
 num := 12
 fmt.Printf("phi(%d) = %d\n", num, EulersTotient(num))
}
```

**Complexities**

- **Time Complexity**: 𝑂(√𝑛) — the loop runs up to the square root of 𝑛. This is significantly faster than checking every number from 1 to 𝑛.
- **Space Complexity**: 𝑂(1) — constant space used.

### Real Use Cases

- **RSA Encryption**: The security of RSA relies on the Totient function. The private key is generated using 𝜙(𝑛), where 𝑛 is the product of two large primes. Specifically, it uses 𝜙(𝑛)=(𝑝−1)(𝑞−1).
- **Euler's Theorem**: States that if gcd(𝑎,𝑛)=1, then 𝑎𝜙(𝑛)≡1(mod𝑛). This is a generalization of Fermat's Little Theorem.
- **Modular Inverse**: 𝜙(𝑛) is used to calculate the modular multiplicative inverse, which is required for solving linear congruences.
- **Group Theory**: 𝜙(𝑛) represents the order of the multiplicative group of integers modulo 𝑛 ((ℤ/𝑛ℤ)×).
- **Cyclotomic Polynomials**: The degree of the 𝑛-th cyclotomic polynomial Φ𝑛(𝑥) is exactly 𝜙(𝑛).

---

## Prime Numbers & Primality Tests

A **Prime Number** is a natural number greater than 1 that cannot be formed by multiplying two smaller natural numbers. In other words, it has exactly two divisors: 1 and itself.

### Key Concepts and Facts

- **Fundamental Theorem of Arithmetic**: Every integer greater than 1 is either a prime or can be represented as a unique product of primes.
- **The Number 1**: Is **not** prime (it only has one divisor).
- **Composite Numbers**: Numbers that have more than two divisors.
- **Density of Primes**: Primes become less frequent as numbers get larger, roughly following the ratio 1/ln(𝑛).
- **Deterministic vs. Probabilistic**:
  - **Deterministic**: Provides a 100% certain answer (e.g., Trial Division).
  - **Probabilistic**: Provides an answer that is "almost certainly" correct, used for massive numbers (e.g., Miller-Rabin).

### Example: Is 29 Prime?

1. Find the square root: √29≈5.38.
2. Check primes up to 5: {2,3,5}.
3. Test divisibility:
   - 29÷2=14.5 (No)
   - 29÷3=9.66 (No)
   - 29÷5=5.8 (No)
4. **Result**: 29 is prime.

### How To Calculate

1. **Trial Division (Simple)**: Check if 𝑛 is divisible by any number from 2 to √𝑛.
2. **Trial Division (Optimized)**: Skip even numbers after checking 2, and skip multiples of 3. Primes greater than 3 are always of the form 6𝑘±1.
3. **Miller-Rabin Test**: Uses modular exponentiation and Fermat’s Little Theorem to test primality with high confidence. This is the standard for 2025 cryptography.

### Golang Code and Complexities

Below is an optimized deterministic test for general use and a mention of the built-in probabilistic test.

```go
package main

import (
 "fmt"
 "math/big"
)

// IsPrimeOptimized: Deterministic Trial Division O(sqrt(n))
func IsPrimeOptimized(n int) bool {
 if n <= 1 { return false }
 if n <= 3 { return true }
 if n%2 == 0 || n%3 == 0 { return false }

 // Primes greater than 3 follow 6k +/- 1 pattern
 for i := 5; i*i <= n; i += 6 {
  if n%i == 0 || n%(i+2) == 0 {
   return false
  }
 }
 return true
}

func main() {
 num := 104729 // The 10,000th prime
 fmt.Printf("Is %d prime? %v\n", num, IsPrimeOptimized(num))

 // Using Go's built-in Miller-Rabin for massive numbers
 bigNum := big.NewInt(12345678910111213)
 // ProbablyPrime(20) runs 20 rounds of Miller-Rabin
 fmt.Printf("Is bigNum prime? %v\n", bigNum.ProbablyPrime(20))
}
```

**Complexities**

- **Trial Division** 𝑂(√𝑛) time, 𝑂(1) space.
- **Miller-Rabin**: 𝑂(𝑘log3𝑛) time, where 𝑘 is the number of rounds.
- **Sieve of Eratosthenes**: 𝑂(𝑛loglog𝑛) time, but 𝑂(𝑛) space (best for finding _all_ primes in a range).

### Real Use Cases

- **Cybersecurity**: RSA encryption relies on the fact that multiplying two 2048-bit primes is easy, but factoring the result back into primes is virtually impossible for modern computers.
- **Cryptocurrency**: Digital signatures (ECDSA) used in Bitcoin and Ethereum rely on prime-order finite fields.
- **Hash Table Sizing**: Using a prime number as the capacity of a hash table minimizes collisions when using simple modulo hashing.
- **PRNG (Pseudo-Random Number Generators)**: Primes are used in Mersenne Twister and Linear Congruential Generators to ensure a long period before the sequence repeats.
- **Error Correction**: Reed-Solomon codes (used in QR codes and satellite comms) utilize prime-based Galois Fields.

---

## Prime Factorization & Divisors

**Prime Factorization** is the process of breaking down a composite number into a product of prime numbers. A **Divisor** (or factor) is any integer that divides the number exactly with no remainder.

### Key Concepts and Facts

- **Fundamental Theorem of Arithmetic**: Every integer greater than 1 has exactly one unique prime factorization (ignoring the order of factors).
- **Relationship**: All divisors of a number are formed by various combinations of its prime factors.
- **Total Number of Divisors**: If the prime factorization is 𝑝𝑎1×𝑝𝑏2×𝑝𝑐3, the total number of divisors is (𝑎+1)(𝑏+1)(𝑐+1).
- **Efficiency**: Finding prime factors is significantly faster than finding all divisors individually.

### Example: The Number 60

1. **Prime Factorization**:
   - 60=2×30
   - 60=2×2×15
   - 60=2×2×3×5→𝟐𝟐×𝟑𝟏×𝟓𝟏
2. **Number of Divisors**: (2+1)×(1+1)×(1+1)=3×2×2=𝟏𝟐.
3. **List of Divisors**: 1, 2, 3, 4, 5, 6, 10, 12, 15, 20, 30, 60.

### How To Calculate

1. **For Prime Factors**:
   - Divide the number by 2 until it's odd.
   - Iterate through odd numbers starting from 3 up to √𝑛.
   - If any number divides 𝑛, it is a prime factor; divide 𝑛 by it repeatedly.
2. **For All Divisors**:
   - Iterate from 1 up to √𝑛.
   - If 𝑛%𝑖==0, then both 𝑖 and 𝑛/𝑖 are divisors.

### Golang Code and Complexities

```go
package main

import (
 "fmt"
 "math"
)

// PrimeFactorization returns a map of prime factors and their exponents
func PrimeFactorization(n int) map[int]int {
 factors := make(map[int]int)

 // Handle 2s
 for n%2 == 0 {
  factors[2]++
  n /= 2
 }

 // Handle odd factors
 for i := 3; i*i <= n; i += 2 {
  for n%i == 0 {
   factors[i]++
   n /= i
  }
 }

 // If n is still > 2, it's a prime factor
 if n > 2 {
  factors[n]++
 }
 return factors
}

// GetAllDivisors returns a slice of all divisors in O(sqrt(n))
func GetAllDivisors(n int) []int {
 var divisors []int
 for i := 1; i*i <= n; i++ {
  if n%i == 0 {
   divisors = append(divisors, i)
   if i != n/i {
    divisors = append(divisors, n/i)
   }
  }
 }
 return divisors
}

func main() {
 num := 60
 fmt.Printf("Prime Factors of %d: %v\n", num, PrimeFactorization(num))
 fmt.Printf("All Divisors of %d: %v\n", num, GetAllDivisors(num))
}
```

**Complexities**

- **Time Complexity**: 𝑂(√𝑛) for both prime factorization and finding all divisors.
- **Space Complexity**: 𝑂(log𝑛) for prime factors (storage of unique primes); 𝑂(√𝑛) for the list of all divisors in the worst case.

### Real Use Cases

- **Data Compression**: Prime factorization is used in some compression algorithms to represent large datasets as products of smaller primes.
- **Cryptography (RSA)**: The backbone of internet security. RSA relies on the extreme difficulty of finding the prime factorization of a number that is the product of two very large primes (e.g., 2048-bit numbers).
- **Scheduling and Cycles**: Finding the Least Common Multiple (LCM) via prime factorization helps determine when multiple periodic tasks will overlap.
- **Computer Graphics**: Factoring screen dimensions or texture sizes into divisors helps in determining optimal grid layouts or mipmap levels.
- **Fraction Simplification**: GCD (Greatest Common Divisor), calculated via prime factors, is used to reduce fractions to their simplest form.

---

## Chinese Remainder Theorem

The **Chinese Remainder Theorem** is a fundamental theorem in number theory that provides a way to solve a system of simultaneous congruences with different moduli.

### Key Concepts and Facts

- **The Problem**: Finding a single number 𝑥 that, when divided by different divisors (𝑚1,𝑚2,…), leaves specific remainders (𝑟1,𝑟2,…).
- **Condition for Uniqueness**: A unique solution for 𝑥 exists modulo 𝑀 (where 𝑀=𝑚1×𝑚2×…) **if and only if** all the moduli are **pairwise co-prime** (gcd(𝑚𝑖,𝑚𝑗)=1).
- **Efficiency**: CRT allows us to perform arithmetic on massive numbers by breaking them down into several calculations on smaller, manageable numbers.

### Example

Find 𝑥 such that:

1. 𝑥≡2(mod3)
2. 𝑥≡3(mod5)
3. 𝑥≡2(mod7)

- **Moduli**: 3,5,7 (all co-prime).
- **Product (𝑀)**: 3×5×7=105.
- **Result**: The smallest positive integer that satisfies all three is**𝑥=23**.
  - 23÷3=7 Remainder **2**
  - 23÷5=4 Remainder **3**
  - 23÷7=3 Remainder **2**

### How To Calculate

1. Calculate the product of all moduli: 𝑀=𝑚1×𝑚2×…×𝑚𝑛.
2. For each congruence 𝑖 :
   - Calculate 𝑀𝑖=𝑀/𝑚𝑖.
   - Find the **Modular Multiplicative Inverse** of 𝑀𝑖 modulo 𝑚𝑖, denoted as 𝑦𝑖.
3. The solution is: 𝑥=(𝑟𝑖×𝑀𝑖×𝑦𝑖)(mod𝑀).

### Golang Code and Complexities

```go
package main

import "fmt"

// Inverse calculates the modular multiplicative inverse using Extended Euclidean Algorithm
func Inverse(a, m int) int {
 m0, y, x := m, 0, 1
 if m == 1 { return 0 }
 for a > 1 {
  q := a / m
  t := m
  m = a % m
  a = t
  t = y
  y = x - q*y
  x = t
 }
 if x < 0 { x += m0 }
 return x
}

// CRT implements the Chinese Remainder Theorem
func CRT(remainders, moduli []int) int {
 M := 1
 for _, m := range moduli {
  M *= m
 }

 result := 0
 for i := 0; i < len(moduli); i++ {
  Mi := M / moduli[i]
  yi := Inverse(Mi, moduli[i])
  result += remainders[i] * Mi * yi
 }

 return result % M
}

func main() {
 r := []int{2, 3, 2}
 m := []int{3, 5, 7}
 fmt.Printf("x is %d\n", CRT(r, m)) // Output: 23
}
```

**Complexities**

- **Time Complexity**: 𝑂(𝑛log(max(𝑚𝑖))), where 𝑛 is the number of congruences. The log factor comes from the Extended Euclidean Algorithm used for the inverse.
- **Space Complexity**: 𝑂(1) beyond storing the input slices.

### Real Use Cases

- **Cryptography (RSA)**: In 2025, CRT is widely used to speed up RSA decryption and signing by up to 4 times. Instead of calculating 𝑚𝑑(mod𝑝𝑞), the device calculates it modulo 𝑝 and modulo 𝑞 separately and combines them.
- **Big Integer Arithmetic**: CRT allows computers to perform operations on numbers larger than 64 bits by splitting the number into several smaller moduli that fit in hardware registers.
- **Secret Sharing Schemes**: Shamir's Secret Sharing can be implemented using CRT to divide a "secret" into multiple parts.
- **Parallel Computing**: Distributed systems use CRT to solve large-scale linear congruence systems in parallel across different nodes.
- **Astronomy**: Historically used to calculate the alignment of planetary cycles and calendars.

---

There are a lot more than this, but this is some of them, will cover later each real problem later
