import Foundation

enum List <A> {
  case Nil
  case Cons(
    @autoclosure () -> A,
    @autoclosure () -> List<A>
  )

  init () {
    self = .Nil
  }
}

func head <A> (xs: List<A>) -> A? {
  switch xs {
  case .Nil:
    return nil
  case let .Cons(head, _):
    return head()
  }
}

func tail <A> (xs: List<A>) -> List<A>? {
  switch xs {
  case .Nil:
    return nil
  case let .Cons(_, tail):
    return tail()
  }
}

private func _length <A> (xs: List<A>, accum: Int) -> Int {
  switch xs {
  case .Nil:
    return accum
  case let .Cons(_, tail):
    return _length(tail(), accum + 1)
  }
}

func length <A> (xs: List<A>) -> Int {
  return _length(xs, 0)
}

func isNil <A> (list: List<A>) -> Bool {
  switch list {
  case .Nil: return true
  case .Cons: return false
  }
}

func cons <A> (head: A, xs: List<A>) -> List<A> {
  return .Cons(head, xs)
}

infix operator +++ {associativity left}
func +++ <A> (x: A, xs: List<A>) -> List<A> {
  return cons(x, xs)
}

prefix operator +++ {}
prefix func +++ <A> (xs: List<A>) -> A -> List<A> {
  return {x in
    return cons(x, xs)
  }
}

postfix operator +++ {}
postfix func +++ <A> (x: A) -> List<A> -> List<A> {
  return {xs in
    return cons(x, xs)
  }
}

func append <A> (xs: List<A>, ys: List<A>) -> List<A> {
  switch xs {
  case .Nil:
    return ys
  case let .Cons(x, tailxs):
    return cons(x(), append(tailxs(), ys))
  }
}

/**
 Semigroup, Monoid
 */
extension List : Semigroup, Monoid {
  func op (list: List<A>) -> List<A> {
    return append(self, list)
  }

  static func mzero () -> List<A> {
    return .Nil
  }
}

/**
 Printable
 */
extension List : Printable, DebugPrintable {
  var description: String {
    get {
      var d = ""
      switch self {
      case .Nil:
        d += "Nil"
      case let .Cons(head, tail):
        d += "\(head()), \(tail().description)"
      }
      return d
    }
  }

  var debugDescription: String {
    get {
      return self.description
    }
  }
}

/**
 Functor
*/
func fmap <A, B> (f: A -> B) -> List<A> -> List<B> {
  return {list in
    switch list {
    case .Nil:
      return .Nil
    case let .Cons(head, tail):
      return .Cons(f(head()), fmap(f)(tail()))
    }
  }
}

/**
 Monad
 */

func bind <A, B> (xs: List<A>, f: A -> List<B>) -> List<B> {
  switch xs {
  case .Nil:
    return .Nil
  case let .Cons(x, tail):
    // why can't the type checker figure out ++ here?
//    return f(x()) ++ bind(tail(), f)
    return append(f(x()), bind(tail(), f))
  }
}

infix operator >>= {associativity left}
func >>= <A, B> (xs: List<A>, f: A -> List<B>) -> List<B> {
  return bind(xs, f)
}


