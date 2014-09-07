
func fixedPoint <A, B> (f: (A -> B) -> (A -> B)) -> (A -> B) {
  return {a in
    return f(fixedPoint(f))(a)
  }
}
