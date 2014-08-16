import Foundation

/**
 Identity function
 */
func identity <A> (x: A) -> A {
  return x
}

/**
 Constant function
 */

func constant <A> (x: A) -> A -> A {
  return {y in
    return x
  }
}

/**
 Function composition
 */

func * <A,B,C> (g: B -> C, f: A -> B) -> (A -> C) {
  return { g(f($0)) }
}

/**
 Pipe operators
 x |> f
 f <| x
 */
infix operator |> {associativity left}
func |> <A, B> (x: A, f: A -> B) -> B {
  return f(x)
}

infix operator <| {associativity right}
func <| <A, B> (f: A -> B, x: A) -> B {
  return f(x)
}

/**
 Currying
 */
func curry <A, B, C> (f: (A, B) -> C) -> A -> B -> C {
  return {a in
    return {b in
      return f(a, b)
    }
  }
}

func uncurry <A, B, C> (f: A -> B -> C) -> (A, B) -> C {
  return {a, b in
    return f(a)(b)
  }
}

/**
 Permuting arguments
 */
func swap <A, B, C> (f: (A, B) -> C) -> (B, A) -> C {
  return {b, a in
    return f(a, b)
  }
}




