import Foundation

/**
 Semigroup
 */
extension Array : Semigroup {
  func op (xs: Array<T>) -> Array<T> {
    return self + xs
  }
}

/**
 Monoid
 */
extension Array : Monoid {
  static func mzero() -> Array<T> {
    return []
  }
}

/**
 Partial application of +
 */
prefix operator + {}
prefix func + <A> (xs: [A]) -> [A] -> [A] {
  return {$0 + xs}
}

postfix operator + {}
postfix func + <A> (xs: [A]) -> [A] -> [A] {
  return {xs + $0}
}

/**
 Concat list of lists
 */
func concat <A> (xss: [[A]]) -> [A] {
  return mconcat(xss)
}

func flatten <A> (xss: [[A]]) -> [A] {
  return concat(xss)
}

/**
 Functor
 */
func fmap <A, B> (f: A -> B) -> [A] -> [B] {
  return {xs in
    return xs.map(f)
  }
}

/**
 Monad
 */

func bind <A, B> (xs: [A], f: A -> [B]) -> [B] {
  return (concat * fmap(f))(xs)
}

infix operator >>= {associativity left}
func >>= <A, B> (xs: [A], f: A -> [B]) -> [B] {
  return bind(xs, f)
}

postfix operator >>= {}
postfix func >>= <A, B> (xs: [A]) -> (A -> [B]) -> [B] {
  return {f in
    return bind(xs, f)
  }
}

prefix operator >>= {}
prefix func >>= <A, B> (f: A -> [B]) -> [A] -> [B] {
  return {xs in
    return bind(xs, f)
  }
}

func join <A> (xss: [[A]]) -> [A] {
  return concat(xss)
}

/**
 Applicative
 */
func pure <A> (x: A) -> [A] {
  return [x]
}

func ap <A, B> (fs: [A -> B]) -> [A] -> [B] {
  return {xs in
    return fs.reduce([], { acc, f in return acc + map(xs, f) })
  }
}

infix operator <*> {associativity left}
func <*> <A, B> (fs: [A -> B], xs: [A]) -> [B] {
  return ap(fs)(xs)
}

postfix operator <*> {}
postfix func <*> <A, B> (fs: [A -> B]) -> [A] -> [B] {
  return ap(fs)
}

prefix operator <*> {}
prefix func <*> <A, B> (xs: [A]) -> [A -> B] -> [B] {
  return {fs in
    return ap(fs)(xs)
  }
}

/**
 Foldable
 */

func foldl <A, B> (f: B -> A -> B) -> B -> [A] -> B {
  return {initial in
    return {xs in
      return xs.reduce(initial, combine: uncurry(f))
    }
  }
}

func foldr <A, B> (f: A -> B -> B) -> B -> [A] -> B {
  return {initial in
    return {xs in
      return xs.reduce(initial, uncurry(f) * flip)
    }
  }
}
