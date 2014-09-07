struct Predicate <A> {
  let test: A -> Bool
  init (_ test: A -> Bool) {
    self.test = test
  }
}

/**
 Contravariant functor
 */
func contramap <A, B> (f: A -> B) -> Predicate<B> -> Predicate<A> {
  return {p in
    return Predicate<A>{ p.test(f($0)) }
  }
}

/**
 Semigroup
 */
extension Predicate : Semigroup {
  func op (p: Predicate<A>) -> Predicate<A> {
    return Predicate<A>{a in
      return self.test(a) && p.test(a)
    }
  }
}
