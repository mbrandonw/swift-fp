import Foundation

protocol Monoid : Semigroup {
  class func mzero () -> Self
}

func mconcat <M: Monoid> (ms: [M]) -> M {
  return ms.reduce(M.mzero(), {$0.op($1)})
}

/**
 We can reduce without an initial value in a monoid
 since we can user mzero as the initial value.
 */
func reduce <S: SequenceType, M: Monoid> (f: (M, S.Generator.Element) -> M) -> S -> M {
  return {s in
    return reduce(s, M.mzero(), f)
  }
}
