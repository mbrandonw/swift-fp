/**
A struct wrap of a generic func.
*/
struct Function <A, B> {
  let f: A -> B
  init (_ f: A -> B) {
    self.f = f
  }
}
