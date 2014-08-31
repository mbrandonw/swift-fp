import Foundation

protocol Semigroup {
  func op (g: Self) -> Self
}

func op <S: Semigroup> (s: S, t: S) -> S {
  return s.op(t)
}

infix operator ++ {associativity left}
func ++ <S: Semigroup> (s: S, t: S) -> S {
  return op(s, t)
}

prefix operator ++ {}
prefix func ++ <S: Semigroup> (t: S) -> S -> S {
  return {s in op(s, t)}
}

postfix operator ++ {}
postfix func ++ <S: Semigroup> (s: S) -> S -> S {
  return {t in op(s, t)}
}

func sconcat <S: Semigroup> (ss: [S]) -> S? {
  if countElements(ss) == 0 {
    return nil
  }
  return ss[1..<ss.count].reduce(ss[0], {$0.op($1)})
}
