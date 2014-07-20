//
//  Tuples.swift
//  swift-fp
//
//  Created by Brandon Williams on 7/18/14.
//  Copyright (c) 2014 Brandon Williams. All rights reserved.
//

import Foundation

/**
 Functional accessors
*/
func _0 <A, B> (x: (A, B)) -> A {
  return x.0
}

func _0 <A, B, C> (x: (A, B, C)) -> A {
  return x.0
}

func _0 <A, B, C, D> (x: (A, B, C, D)) -> A {
  return x.0
}

func _0 <A, B, C, D, E> (x: (A, B, C, D, E)) -> A {
  return x.0
}

func _0 <A, B, C, D, E, F> (x: (A, B, C, D, E, F)) -> A {
  return x.0
}

func _0 <A, B, C, D, E, F, G> (x: (A, B, C, D, E, F, G)) -> A {
  return x.0
}

func _1 <A, B> (x: (A, B)) -> B {
  return x.1
}

func _1 <A, B, C> (x: (A, B, C)) -> B {
  return x.1
}

func _1 <A, B, C, D> (x: (A, B, C, D)) -> B {
  return x.1
}

func _1 <A, B, C, D, E> (x: (A, B, C, D, E)) -> B {
  return x.1
}

func _1 <A, B, C, D, E, F> (x: (A, B, C, D, E, F)) -> B {
  return x.1
}

func _1 <A, B, C, D, E, F, G> (x: (A, B, C, D, E, F, G)) -> B {
  return x.1
}

func _2 <A, B, C> (x: (A, B, C)) -> C {
  return x.2
}

func _2 <A, B, C, D> (x: (A, B, C, D)) -> C {
  return x.2
}

func _2 <A, B, C, D, E> (x: (A, B, C, D, E)) -> C {
  return x.2
}

func _2 <A, B, C, D, E, F> (x: (A, B, C, D, E, F)) -> C {
  return x.2
}

func _2 <A, B, C, D, E, F, G> (x: (A, B, C, D, E, F, G)) -> C {
  return x.2
}

func _3 <A, B, C, D> (x: (A, B, C, D)) -> D {
  return x.3
}

func _3 <A, B, C, D, E> (x: (A, B, C, D, E)) -> D {
  return x.3
}

func _3 <A, B, C, D, E, F> (x: (A, B, C, D, E, F)) -> D {
  return x.3
}

func _3 <A, B, C, D, E, F, G> (x: (A, B, C, D, E, F, G)) -> D {
  return x.3
}

func _4 <A, B, C, D, E> (x: (A, B, C, D, E)) -> E {
  return x.4
}

func _4 <A, B, C, D, E, F> (x: (A, B, C, D, E, F)) -> E {
  return x.4
}

func _4 <A, B, C, D, E, F, G> (x: (A, B, C, D, E, F, G)) -> E {
  return x.4
}

func _5 <A, B, C, D, E, F> (x: (A, B, C, D, E, F)) -> F {
  return x.5
}

func _5 <A, B, C, D, E, F, G> (x: (A, B, C, D, E, F, G)) -> F {
  return x.5
}

func _6 <A, B, C, D, E, F, G> (x: (A, B, C, D, E, F, G)) -> G {
  return x.6
}

/**
 Flip
 
 Precompose with a function (B, A) -> C to turn it into
 a function (A, B) -> C.
*/
func flip <A, B> (x: (A, B)) -> (B, A) {
  return (x.1, x.0)
}

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
