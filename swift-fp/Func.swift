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

infix operator * {associativity left}
func * <A,B,C> (g: B -> C, f: A -> B) -> (A -> C) {
  return { g(f($0)) }
}

infix operator ^ {associativity left}
func ^ <A> (f: A -> A, n: UInt) -> A -> A {
  if n == 0 {
    return identity
  }
  return f * (f^(n-1))
}

/**
 Pipe operators
 x |> f   f(x)
 f <| x   f(x)
 f |> g   f(g)
 f <| g   g(f)
 */
infix operator |> {associativity left}
func |> <A, B> (x: A, f: A -> B) -> B {
  return f(x)
}

func |> <A, B, C> (f: A -> B, g: B -> C) -> A -> C {
  return { g(f($0)) }
}

infix operator <| {associativity right}
func <| <A, B> (f: A -> B, x: A) -> B {
  return f(x)
}

func <| <A, B, C> (f: B -> C, g: A -> B) -> A -> C {
  return { f(g($0)) }
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


func curry <A, B, C, D> (f: (A, B, C) -> D) -> A -> B -> C -> D {
  return {a in
    return {b in
      return {c in
        return f(a, b, c)
      }
    }
  }
}

func uncurry <A, B, C> (f: A -> B -> C) -> (A, B) -> C {
  return {a, b in
    return f(a)(b)
  }
}

func uncurry <A, B, C, D> (f: A -> B -> C -> D) -> (A, B, C) -> D {
  return {a, b, c in
    return f(a)(b)(c)
  }
}

/**
 Permuting arguments
 */
func flip <A, B, C> (f: (A, B) -> C) -> (B, A) -> C {
  return {b, a in
    return f(a, b)
  }
}
