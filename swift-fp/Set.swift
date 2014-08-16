import Foundation

struct Set<A: Hashable> {
  var _data: [A:Bool]

  init() {
    _data = [A:Bool]()
  }

  init(_ elements: [A]) {
    self.init()
    for element in elements {
      _data[element] = true
    }
  }

  init(_ element: A) {
    self.init([element])
  }

  init(_ set: Set<A>) {
    self.init(set.elements())
  }
}

extension Set {
  mutating func add(element: A) -> Set<A> {
    _data[element] = true
    return self
  }

  mutating func remove(element: A) -> Set<A> {
    _data.removeValueForKey(element)
    return self
  }

  func elements () -> [A] {
    return Array(_data.keys)
  }

  var count: Int {
    get {
      return countElements(_data.keys)
    }
  }
}

/**
 Subscripting
 */
extension Set {
  subscript(element: A) -> Bool {
    return _data[element] != nil
  }
}

/**
 Equatable
 */
extension Set : Equatable {}
func == <A> (lhs: Set<A>, rhs: Set<A>) -> Bool {
  return lhs.count == rhs.count && lhs.elements().filter {rhs[$0]}.count == lhs.count
}

/**
 BooleanType
 */
extension Set : BooleanType {
  var boolValue: Bool { get {
    return elements().count > 0
    }
  }
}

/**
 Sequence
 */
struct SetGenerator<A> : GeneratorType {
  var items: Slice<A>

  mutating func next() -> A? {
    if items.isEmpty { return nil }
    let ret = items[0]
    items = items[1..<items.count]
    return ret
  }
}

extension Set : SequenceType {
  func generate() -> SetGenerator<A> {
    return SetGenerator(items: elements()[0..<count])
  }
}

/**
 ArrayLiteralConvertible
 */
extension Set : ArrayLiteralConvertible {
  static func convertFromArrayLiteral(elements: A...) -> Set<A> {
    return Set<A>(elements)
  }
}

/**
 countElements
 */
func countElements <T> (set: Set<T>) -> Int {
  return set.count
}

/**
 Set operations
 */
func union <A> (s1: Set<A>, s2: Set<A>) -> Set<A> {
  return Set<A>(s1.elements() + s2.elements())
}

func union <A> (set: Set<A>, element: A) -> Set<A> {
  return Set<A>(set.elements() + [element])
}

func union <A> (element: A, set: Set<A>) -> Set<A> {
  return union(set, element)
}

/**
 Functor
 */
func fmap <A, B> (f: A -> B) -> Set<A> -> Set<B> {
  return {set in
    return Set<B>(fmap(f)(set.elements()))
  }
}

/**
 Monad
 */
func unit <A> (x: A) -> Set<A> {
  return Set<A>(x)
}

func bind <A, B> (set: Set<A>, f: A -> Set<B>) -> Set<B> {
  return set.elements().reduce(Set<B>()) {acc, a in
    return union(acc, f(a))
  }
}

infix operator >>= {}
func >>= <A, B> (set: Set<A>, f: A -> Set<B>) -> Set<B> {
  return bind(set, f)
}


