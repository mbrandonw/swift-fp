//
//  Optional.swift
//  swift-fp
//
//  Created by Brandon Williams on 7/18/14.
//  Copyright (c) 2014 Brandon Williams. All rights reserved.
//

import Foundation

/**
 */
func nilFunction <A, B> (x: A) -> B? {
  return nil
}

/**
 Functor
 */
func fmap <A, B> (f: A -> B) -> A? -> B? {
  return {x in
    switch x {
    case .Some(let x): return f(x)
    case .None: return nil
    }
  }
}

/**
 Monad
 */
func bind <A, B> (x: A?) -> (A -> B?) -> B? {
  return {f in
    switch x {
    case .Some(let x): return f(x)
    case .None: return nil
    }
  }
}

operator infix >>= {associativity left}
@infix func >>= <A, B> (x: A?, f: A -> B?) -> B? {
  return bind(x)(f)
}

operator postfix >>= {}
@postfix func >>= <A, B> (x: A?) -> (A -> B?) -> B? {
  return bind(x)
}

operator prefix >>= {}
@postfix func >>= <A, B> (f: A -> B?) -> A? -> B? {
  return {x in
    return bind(x)(f)
  }
}

/**
 Applicative
 */
func pure <A> (x: A) -> A? {
  return x
}

func ap <A, B> (f: (A -> B)?) -> A? -> B? {
  switch f {
  case .Some(let f): return fmap(f)
  case .None: return nilFunction
  }
}

operator infix <*> {associativity left}
@infix func <*> <A, B> (f: (A -> B)?, x: A?) -> B? {
  return ap(f)(x)
}

operator postfix <*> {}
@postfix func <*> <A, B> (f: (A -> B)?) -> A? -> B? {
  return ap(f)
}

operator prefix <*> {}
@prefix func <*> <A, B> (x: A?) -> (A -> B)? -> B? {
  return {f in
    return ap(f)(x)
  }
}
