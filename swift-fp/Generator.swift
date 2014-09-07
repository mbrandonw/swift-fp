func append <G: GeneratorType> (lhs: G, rhs: G) -> GeneratorOf<G.Element> {
  var _lhs = lhs
  var _rhs = rhs

  return GeneratorOf {
    if let x = _lhs.next() {
      return x
    } else if let x = _rhs.next() {
      return x
    }
    return nil
  }
}

/**
 Semigroup and monoid
 */
extension GeneratorOf : Semigroup, Monoid {
  func op (s: GeneratorOf<T>) -> GeneratorOf<T> {
    return append(self, s)
  }

  static func mzero () -> GeneratorOf<T> {
    return GeneratorOf<T> {
      return nil
    }
  }
}
