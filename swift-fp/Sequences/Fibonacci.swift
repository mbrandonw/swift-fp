struct FibonacciSequence : SequenceType {
  func generate() -> GeneratorOf<UInt> {
    var f2: UInt = 1
    var f1: UInt = 1
    return GeneratorOf<UInt>() {
      (f2, f1) = (f2 + f1, f2)
      return f2
    };
  }
}
