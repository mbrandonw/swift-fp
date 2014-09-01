import Foundation

struct Writer <A> {
  var value: A
  var log: String

  init (_ value: A, _ log: String = "") {
    self.value = value
    self.log = log
  }
}

func writer <A> (value: A, log: String) -> Writer<A> {
  return Writer<A>(value, log)
}

func value <A> (w: Writer<A>) -> A {
  return w.value
}

func log <A> (w: Writer<A>) -> String {
  return w.log
}

/**
 Printable
 */
extension Writer : Printable {
  var description: String {
    get {
      return "\(value) (log: \(log))"
    }
  }
}

/**
 Functor
 */
func fmap <A, B> (f: A -> B) -> Writer<A> -> Writer<B> {
  return {w in
    return Writer<B>((f * value)(w), log(w))
  }
}

/** 
 Monad
 */
func unit <A> (x: A) -> Writer<A> {
  return Writer<A>(x)
}

func bind <A, B> (x: Writer<A>) -> (A -> Writer<B>) -> Writer<B> {
  return {f in
    let y = (f * value)(x)
    return Writer<B>(value(y), "\(log(x)) | \(log(y))")
  }
}

infix operator >>= {}
func >>= <A, B> (x: Writer<A>, f: A -> Writer<B>) -> Writer<B> {
  return bind(x)(f)
}

/**
 Applicative
 */
func ap <A, B> (wf: Writer<A -> B>) -> Writer<A> -> Writer<B> {
  return {w in
    return Writer<B>(wf.value(w.value))
  }
}
