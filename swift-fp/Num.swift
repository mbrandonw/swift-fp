import Foundation

/**
 Num typeclass
 */
protocol Num {
  class func zero() -> Self
  func add(y: Self) -> Self
  func multiply(y: Self) -> Self
}

protocol SignedNum : Num {
  func negate() -> Self
}

/**
 Partial application of * and +
 */
prefix operator * {}
prefix func * <A: Num> (x: A) -> A -> A {
  return { $0.multiply(x) }
}

postfix operator * {}
postfix func * <A: Num> (x: A) -> A -> A {
  return { x.multiply($0) }
}

prefix operator + {}
prefix func + <A: Num> (x: A) -> A -> A {
  return { $0.add(x) }
}

postfix operator + {}
postfix func + <A: Num> (x: A) -> A -> A {
  return { x.add($0) }
}

/**
 Extensions of core data types
 */
extension Int8: SignedNum {
  typealias T = Int8
  static func zero() -> T { return 0 }
  func add(y: T) -> T { return self + y }
  func multiply(y: T) -> T { return self * y }
  func negate() -> T { return -self }
}

extension Int16: SignedNum {
  typealias T = Int16
  static func zero() -> T { return 0 }
  func add(y: T) -> T { return self + y }
  func multiply(y: T) -> T { return self * y }
  func negate() -> T { return -self }
}

extension Int32: SignedNum {
  typealias T = Int32
  static func zero() -> T { return 0 }
  func add(y: T) -> T { return self + y }
  func multiply(y: T) -> T { return self * y }
  func negate() -> T { return -self }
}

extension Int64: SignedNum {
  typealias T = Int64
  static func zero() -> T { return 0 }
  func add(y: T) -> T { return self + y }
  func multiply(y: T) -> T { return self * y }
  func negate() -> T { return -self }
}

extension Int: SignedNum {
  typealias T = Int
  static func zero() -> T { return 0 }
  func add(y: T) -> T { return self + y }
  func multiply(y: T) -> T { return self * y }
  func negate() -> T { return -self }
}

extension UInt8: Num {
  typealias T = UInt8
  static func zero() -> T { return 0 }
  func add(y: T) -> T { return self + y }
  func multiply(y: T) -> T { return self * y }
}

extension UInt16: Num {
  typealias T = UInt16
  static func zero() -> T { return 0 }
  func add(y: T) -> T { return self + y }
  func multiply(y: T) -> T { return self * y }
}

extension UInt32: Num {
  typealias T = UInt32
  static func zero() -> T { return 0 }
  func add(y: T) -> T { return self + y }
  func multiply(y: T) -> T { return self * y }
}

extension UInt64: Num {
  typealias T = UInt64
  static func zero() -> T { return 0 }
  func add(y: T) -> T { return self + y }
  func multiply(y: T) -> T { return self * y }
}

extension UInt: Num {
  typealias T = UInt
  static func zero() -> T { return 0 }
  func add(y: T) -> T { return self + y }
  func multiply(y: T) -> T { return self * y }
}

extension Float: SignedNum {
  typealias T = Float
  static func zero() -> T { return 0.0 }
  func add(y: T) -> T { return self + y }
  func multiply(y: T) -> T { return self * y }
  func negate() -> T { return -self }
}

extension Double: SignedNum {
  typealias T = Double
  static func zero() -> T { return 0.0 }
  func add(y: T) -> T { return self + y }
  func multiply(y: T) -> T { return self * y }
  func negate() -> T { return -self }
}
