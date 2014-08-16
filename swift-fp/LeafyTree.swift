import Foundation

/**
 A tree where only the leaves hold values, and not the nodes.
 */
enum LeafyTree <A> {
  case Empty
  case Leaf(@autoclosure () -> A)
  case Node(
    @autoclosure () -> LeafyTree<A>,
    @autoclosure () -> LeafyTree<A>
  )
}

/**
 Functor
 */

func fmap <A, B> (f: A -> B) -> LeafyTree<A> -> LeafyTree<B> {
  return {tree in
    switch tree {
    case .Empty:
      return .Empty
    case let .Leaf(value):
      return .Leaf(f(value()))
    case let .Node(left, right):
      return .Node(
        fmap(f)(left()),
        fmap(f)(right())
      )
    }
  }
}

/**
 Monad
 */

func bind <A, B> (tree: LeafyTree<A>, f: A -> LeafyTree<B>) -> LeafyTree<B> {
  switch tree {
  case .Empty:
    return .Empty
  case let .Leaf(value):
    return f(value())
  case let .Node(left, right):
    return .Node(bind(left(), f), bind(right(), f))
  }
}

infix operator >>= {associativity left}
func >>= <A, B> (tree: LeafyTree<A>, f: A -> LeafyTree<B>) -> LeafyTree<B> {
  return bind(tree, f)
}

postfix operator >>= {}
postfix func >>= <A, B> (tree: LeafyTree<A>) -> (A -> LeafyTree<B>) -> LeafyTree<B> {
  return {f in
    return bind(tree, f)
  }
}

prefix operator >>= {}
prefix func >>= <A, B> (f: A -> LeafyTree<B>) -> LeafyTree<A> -> LeafyTree<B> {
  return {tree in
    return bind(tree, f)
  }
}

/**
Foldable
*/

func foldl <A, B> (f: A -> B -> A) -> A -> LeafyTree<B> -> A {
  return {initial in
    return {tree in
      switch tree {
      case .Empty:
        return initial
      case let .Leaf(value):
        return f(initial)(value())
      case let .Node(left, right):
        let leftAccum = foldl(f)(initial)(left())
        return foldl(f)(leftAccum)(right())
      }
    }
  }
}






