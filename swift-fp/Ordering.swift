import Foundation

enum Ordering {
  case EQ
  case LT
  case GT
}

extension Ordering : Printable, DebugPrintable {
  var description: String {
    get {
      switch self {
      case .EQ: return "{Ordering EQ}"
      case .LT: return "{Ordering LT}"
      case .GT: return "{Ordering GT}"
      }
    }
  }

  var debugDescription: String {
    get {
      return self.description
    }
  }
}

extension Ordering : Semigroup {
  func op (g: Ordering) -> Ordering {
    switch (self, g) {
    case (.LT, _): return .LT
    case (.GT, _): return .GT
    case let (.EQ, v): return v
    }
  }
} 

extension Ordering : Monoid {
  static func mzero () -> Ordering {
    return .EQ
  }
}

/**
 A semigroup structure on functions (A -> Ordering)
 */
func sop <A> (f: A -> Ordering, g: A -> Ordering) -> A -> Ordering {
  return {a in
    return sop(f(a), g(a))
  }
}

infix operator ++ {associativity left}
func ++ <A> (f: A -> Ordering, g: A -> Ordering) -> A -> Ordering {
  return sop(f, g)
}

prefix operator ++ {}
prefix func ++ <A> (g: A -> Ordering) -> (A -> Ordering) -> (A -> Ordering) {
  return {f in f ++ g}
}

postfix operator ++ {}
postfix func ++ <A> (f: A -> Ordering) -> (A -> Ordering) -> (A -> Ordering) {
  return {g in f ++ g}
}

/**
 A monoid structure on functions into Ordering
 */
func mzero <A> (x: A) -> Ordering {
  return .EQ
}

/**
 Equatable
 */
extension Ordering : Equatable {
}

func == (lhs: Ordering, rhs: Ordering) -> Bool {
  switch (lhs, rhs) {
  case (.LT, .LT), (.GT, .GT), (.EQ, .EQ):
    return true
  case (_, _):
    return false
  }
}

/**
 Comprable
 */
extension Ordering : Comparable {
}

func < (lhs: Ordering, rhs: Ordering) -> Bool {
  switch (lhs, rhs) {
  case (.LT, .EQ), (.LT, .GT), (.LT, .GT), (.EQ, .GT):
    return true
  case (_, _):
    return false
  }
}

/**
 Spaceship operator
 */
infix operator <=> {associativity left}
func <=> <A: Comparable> (left: A, right: A) -> Ordering {
  if left < right { return .LT }
  if left > right { return .GT }
  return .EQ
}

/**
 Converts a function that maps into a comparable type to
 one that can order.
*/
func ordering <A: Comparable> (f: (A, A) -> Bool) -> (A, A) -> Ordering {
  return {x, y in
    if x == y {
      return .EQ
    } else if x < y {
      return .LT
    } else {
      return .GT
    }
  }
}

func ordering <A, B: Comparable> (f: A -> B) -> (A, A) -> Ordering {
  return {x, y in
    let fx = f(x)
    let fy = f(y)
    if fx == fy { return .EQ }
    if fx <  fy { return .LT }
    return .GT
  }
}
