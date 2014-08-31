//
//  Either.swift
//  swift-fp
//
//  Created by Brandon Williams on 8/30/14.
//  Copyright (c) 2014 Kickstarter. All rights reserved.
//

import Foundation

enum Either <A, B> {
  case Left(@autoclosure () -> A)
  case Right(@autoclosure () -> B)
}

/**
 Printable, DebugPrintable
 */
extension Either : Printable, DebugPrintable {
  var description: String {
    get {
      switch self {
      case let .Left(left): return "{Left: \(left())}"
      case let .Right(right): return "{Right: \(right())}"
      }
    }
  }

  var debugDescription: String {
    get {
      return self.description
    }
  }
}

/**
 Functor
 */
func fmap <A, B, C, D> (f: A -> C, g: B -> D) -> Either<A, B> -> Either<C, D> {
  return {either in
    switch either {
    case let .Left(left): return Either<C, D>.Left(f(left()))
    case let .Right(right): return Either<C, D>.Right(g(right()))
    }
  }
}

// Either<_, B>
func fmap <A, B, C> (f: A -> C) -> Either<A, B> -> Either<C, B> {
  return fmap(f, identity)
}

// Either<A, _>
func fmap <A, B, D> (g: B -> D) -> Either<A, B> -> Either<A, D> {
  return fmap(identity, g)
}

/**
 Monad
 */
// Either<_, B>
func bind <A, B, C> (x: Either<A, C>, f: A -> Either<B, C>) -> Either<B, C> {
  switch x {
  case let .Left(left):   return f(left())
  case let .Right(right): return .Right(right())
  }
}

// Either<A, _>
func bind <A, B, D> (x: Either<A, B>, f: B -> Either<A, D>) -> Either<A, D> {
  switch x {
  case let .Left(left):   return .Left(left())
  case let .Right(right): return f(right())
  }
}

infix operator >>= {associativity left}
func >>= <A, B, C> (x: Either<A, C>, f: A -> Either<B, C>) -> Either<B, C> {
  return bind(x, f)
}

prefix operator >>= {}
prefix func >>= <A, B, C> (x: Either<A, C>) -> (A -> Either<B, C>) -> Either<B, C> {
  return {f in
    return bind(x, f)
  }
}

postfix operator >>= {}
postfix func >>= <A, B, C> (f: A -> Either<B, C>) -> Either<A, C> -> Either<B, C> {
  return {x in
    return bind(x, f)
  }
}

func >>= <A, B, D> (x: Either<A, B>, f: B -> Either<A, D>) -> Either<A, D> {
  return bind(x, f)
}

prefix func >>= <A, B, D> (x: Either<A, B>) -> (B -> Either<A, D>) -> Either<A, D> {
  return {f in
    return bind(x, f)
  }
}

postfix func >>= <A, B, D> (f: B -> Either<A, D>) -> Either<A, B> -> Either<A, D> {
  return {x in
    return bind(x, f)
  }
}

/**
 Applicative
 */










