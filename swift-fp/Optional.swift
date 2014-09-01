import Foundation

/**
 Getters
 */
func isNone <A> (x: A?) -> Bool {
  switch x {
  case .Some: return false
  case .None: return true
  }
}

func isSome <A> (x: A?) -> Bool {
  return !isNone(x)
}

func fromSome <A> (x: A?) -> A {
  return x!
}

/**
 Constant nil function
 */
func nilFunction <A, B> (x: A) -> B? {
  return nil
}

/**
 Flatten
 */
func flatten <A> (x: A??) -> A? {
  if let x = x {
    return x
  }
  return nil
}

/**
 Functor
 */
func fmap <A, B> (f: A -> B) -> A? -> B? {
  return {x in
    switch x {
    case let .Some(x): return f(x)
    case .None: return nil
    }
  }
}

/**
 Monad
 */
func bind <A, B> (x: A?) -> (A -> B?) -> B? {
  return {f in
    switch x {
    case let .Some(x): return f(x)
    case .None: return nil
    }
  }
}

infix operator >>= {associativity left}
func >>= <A, B> (x: A?, f: A -> B?) -> B? {
  return bind(x)(f)
}

postfix operator >>= {}
postfix func >>= <A, B> (x: A?) -> (A -> B?) -> B? {
  return bind(x)
}

prefix operator >>= {}
prefix func >>= <A, B> (f: A -> B?) -> A? -> B? {
  return {x in
    return bind(x)(f)
  }
}

func join <A> (x: A??) -> A? {
  return flatten(x)
}

/**
 Applicative
 */
func pure <A> (x: A) -> A? {
  return x
}

func ap <A, B> (f: (A -> B)?) -> A? -> B? {
  switch f {
  case let .Some(f): return fmap(f)
  case .None: return nilFunction
  }
}

infix operator <*> {associativity left}
func <*> <A, B> (f: (A -> B)?, x: A?) -> B? {
  return ap(f)(x)
}

postfix operator <*> {}
postfix func <*> <A, B> (f: (A -> B)?) -> A? -> B? {
  return ap(f)
}

prefix operator <*> {}
prefix func <*> <A, B> (x: A?) -> (A -> B)? -> B? {
  return {f in
    return ap(f)(x)
  }
}
