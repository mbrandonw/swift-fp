//
//  Tuples.swift
//  swift-fp
//
//  Created by Brandon Williams on 7/18/14.
//  Copyright (c) 2014 Brandon Williams. All rights reserved.
//

import Foundation

/**
 Functor (pairs)
*/
func fmap <A, B, C, D> (f: (A -> B, C -> D)) -> (A, C) -> (B, D) {
  return {(a, c) in
    return (f.0(a), f.1(c))
  }
}

func fmap <A, B, C, D> (f: A -> B, g: C -> D) -> (A, C) -> (B, D) {
  return fmap((f, g))
}

/**
Functor (triples)
*/
func fmap <A, B, C, D, E, F> (f: (A -> B, C -> D, E -> F)) -> (A, C, E) -> (B, D, F) {
  return {(a, c, e) in
    return (f.0(a), f.1(c), f.2(e))
  }
}

func fmap <A, B, C, D, E, F> (f: A -> B, g: C -> D, h: E -> F) -> (A, C, E) -> (B, D, F) {
  return fmap((f, g, h))
}
