struct FactorialSequence : SequenceType {
  func generate() -> GeneratorOf<Int> {
    var fn: Int = 1
    var n: Int = 0
    return GeneratorOf<Int>() {
      (fn, n) = (fn * (n + 1), n + 1)
      return fn
    };
  }
}
