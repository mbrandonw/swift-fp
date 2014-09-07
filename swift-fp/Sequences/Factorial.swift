struct FactorialSequence : SequenceType {
  func generate() -> GeneratorOf<UInt> {
    var fn: UInt = 1
    var n: UInt = 0
    return GeneratorOf<UInt>() {
      (fn, n) = (fn * (n + 1), n + 1)
      return fn
    };
  }
}
