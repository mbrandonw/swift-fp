import Foundation

enum Tree <A> {
  case Empty
  case Leaf(@autoclosure () -> A)
  case Node(
    @autoclosure () -> Tree<A>,
    @autoclosure () -> A,
    @autoclosure () -> Tree<A>
  )

  init () {
    self = .Empty
  }
}

/**
 Helper accessors
 */
func empty <A> (tree: Tree<A>) -> Bool {
  switch tree {
  case .Empty: return true
  case .Leaf, .Node: return false
  }
}

/**
 Printable
 */

extension Tree : Printable {
  var description: String {
    get {
      return _description("")
    }
  }

  private func _description(indent: String) -> String {
    switch self {
    case .Empty:
      return "\(indent)(empty)"
    case let .Leaf(value):
      return "\(indent)\(value())"
    case let .Node(left, value, right):
      let leftDescription = left()._description(indent + "|--")
      let rightDescription = right()._description(indent + "|--")
      return "\(indent)\(value())\n\(leftDescription)\n\(rightDescription)"
    }
  }
}

/**
 Functor
 */
func fmap <A, B> (f: A -> B) -> Tree<A> -> Tree<B> {
  return {tree in
    switch tree {
    case .Empty:
      return .Empty
    case let .Leaf(value):
      return Tree<B>.Leaf(f(value()))
    case let .Node(left, value, right):
      return Tree<B>.Node(
        fmap(f)(left()),
        f(value()),
        fmap(f)(right())
      )
    }
  }
}

/**
 Monad
 */

// Can't do it in any natural way!

/**
 Foldable
 */

func foldl <A, B> (f: A -> B -> A) -> A -> Tree<B> -> A {
  return {initial in
    return {tree in
      switch tree {
      case .Empty:
        return initial
      case let .Leaf(value):
        return f(initial)(value())
      case let .Node(left, value, right):
        let leftAccum = foldl(f)(initial)(left())
        let rightAccum = foldl(f)(leftAccum)(right())
        return f(rightAccum)(value())
      }
    }
  }
}

