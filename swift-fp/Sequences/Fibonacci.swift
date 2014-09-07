struct FibonacciSequence : SequenceType {
  func generate() -> GeneratorOf<Int> {
    var f2: Int = 1
    var f1: Int = 1
    return GeneratorOf<Int>() {
      (f2, f1) = (f2 + f1, f2)
      return f2
    };
  }
}
