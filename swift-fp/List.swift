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

private func _length <A> (xs: List<A>, accum: UInt) -> UInt {
  switch xs {
  case .Nil:
    return accum
  case let .Cons(_, tail):
    return _length(tail(), accum + 1)
  }
}

func length <A> (xs: List<A>) -> UInt {
  return _length(xs, 0)
}

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
