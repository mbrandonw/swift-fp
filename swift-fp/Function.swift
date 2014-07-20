//
//  Function.swift
//  swift-fp
//
//  Created by Brandon Williams on 7/18/14.
//  Copyright (c) 2014 Brandon Williams. All rights reserved.
//

import Foundation

/**
 Identity function
 */
func identity <A> (x: A) -> A {
  return x
}

/**
 Constant function
 */
func constant <A> (x: A) -> A -> A {
  return {y in
    return x
  }
}

/**
 Function composition
(f * g)(x) = f(g(x))
 */
@infix func * <A,B,C> (g: B -> C, f: A -> B) -> (A -> C) {
  return { g(f($0)) }
}

/**
 Pipe operators
 x |> f
 f <| x
 */
operator infix |> {associativity left}
@infix func |> <A, B> (x: A, f: A -> B) -> B {
  return f(x)
}

operator infix <| {associativity right}
@infix func <| <A, B> (f: A -> B, x: A) -> B {
  return f(x)
}
