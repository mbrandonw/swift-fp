import Foundation

func gcd (a: Int, b: Int) -> Int {
  switch (a, b) {
  case (_, 0): return abs(a)
  case (0, _): return abs(b)
  default: return gcd(b, a % b)
  }
}

/**
Returns (x, y, g) such that
> ax + by = gcd(a, b) = g
*/
func xgcd (a: Int, b: Int) -> (Int, Int, Int) {
  switch (a, b) {
  case (_, 0): return (1, 0, a)
  default:
    let (x, y, g) = xgcd(b, a % b)
    return (y, x - (Int)(a/b) * y, g)
  }
}

func modinv (a: Int, m: Int) -> Int? {
  let (x, y, g) = xgcd(a, m)
  if g == 1 {
    return x % m
  }
  return nil
}

/**
 Factorial
 */
private func tailFactorial (n: UInt, accum: UInt) -> UInt {
  if n == 1 {
    return accum
  }
  return tailFactorial(n-1, n * accum)
}

func factorial (n: UInt) -> UInt {
  return tailFactorial(n, 1)
}
