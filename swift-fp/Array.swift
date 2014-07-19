//
//  Array.swift
//  swift-fp
//
//  Created by Brandon Williams on 7/18/14.
//  Copyright (c) 2014 Brandon Williams. All rights reserved.
//

import Foundation

operator prefix + {}
@prefix func + <A> (xs: [A]) -> [A] -> [A] {
  return {$0 + xs}
}

operator postfix + {}
@postfix func + <A> (xs: [A]) -> [A] -> [A] {
  return {xs + $0}
}

/**
 Concat list of lists
 */
func concat <A> (xss: [[A]]) -> [A] {
  return xss.reduce([], +)
}

/**
 Functor
 */
func fmap <A, B> (f: A -> B) -> [A] -> [B] {
  return {xs in
    return xs.map(f)
  }
}

/**
 Monad
 */
func bind <A, B> (xs: [A], f: A -> [B]) -> [B] {
  return (concat * fmap(f))(xs)
}

operator infix >>= {associativity left}
@infix func >>= <A, B> (xs: [A], f: A -> [B]) -> [B] {
  return bind(xs, f)
}

operator postfix >>= {}
@postfix func >>= <A, B> (xs: [A]) -> (A -> [B]) -> [B] {
  return {f in
    return bind(xs, f)
  }
}

operator prefix >>= {}
@prefix func >>= <A, B> (f: A -> [B]) -> [A] -> [B] {
  return {xs in
    return bind(xs, f)
  }
}

/**
 Additive monad
 */
func mzero <A> () -> [A] {
  return []
}

func mplus <A> (xs: [A], ys: [A]) -> [A] {
  return xs + ys
}

/**
 Applicative
 */
func pure <A> (x: A) -> [A] {
  return [x]
}

func ap <A, B> (fs: [A -> B]) -> [A] -> [B] {
  return {xs in
    return fs.reduce([], { acc, f in return acc + map(xs, f) })
  }
}

operator infix <*> {associativity left}
@infix func <*> <A, B> (fs: [A -> B], xs: [A]) -> [B] {
  return ap(fs)(xs)
}

operator postfix <*> {}
@postfix func <*> <A, B> (fs: [A -> B]) -> [A] -> [B] {
  return ap(fs)
}

operator prefix <*> {}
@prefix func <*> <A, B> (xs: [A]) -> [A -> B] -> [B] {
  return {fs in
    return ap(fs)(xs)
  }
}
