
enum Expression <A> {
  case Const(@autoclosure () -> A)
  case Add(
    @autoclosure () -> Expression<A>,
    @autoclosure () -> Expression<A>
  )
  case Multiply(
    @autoclosure () -> Expression<A>,
    @autoclosure () -> Expression<A>
  )
}

/**
 Evaluation
 */
func eval <A: Num> (expr: Expression<A>) -> A {
  switch expr {
  case let .Const(value):
    return value()
  case let .Add(left, right):
    return eval(left()) + eval(right())
  case let .Multiply(left, right):
    return eval(left()) * eval(right())
  }
}

/**
 Functor
 */
func fmap <A, B> (f: A -> B) -> Expression<A> -> Expression<B> {
  return {expr in
    switch expr {
    case let .Const(value):
      return .Const(f(value()))
    case let .Add(left, right):
      return .Add(
        fmap(f)(left()),
        fmap(f)(right())
      )
    case let .Multiply(left, right):
      return .Multiply(
        fmap(f)(left()),
        fmap(f)(right())
      )
    }
  }
}
