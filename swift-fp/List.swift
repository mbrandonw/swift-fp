import Foundation

enum List <A> {
  case Nil
  case Cons(
    @autoclosure () -> A,
    @autoclosure () -> List<A>
  )
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
