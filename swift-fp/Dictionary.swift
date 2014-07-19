//
//  Dictionary.swift
//  swift-fp
//
//  Created by Brandon Williams on 7/18/14.
//  Copyright (c) 2014 Brandon Williams. All rights reserved.
//

import Foundation

func merge <A: Hashable, B> (x: [A:B], y: [A:B]) -> [A:B] {
  var ret = x
  for (key, value) in y {
    ret[key] = value
  }
  return ret
}

func merge <A: Hashable, B> (kvs: [A:B], kv: (A, B)) -> [A:B] {
  return merge(kvs, [kv.0 : kv.1])
}

func merge <A: Hashable, B> (kv: (A, B), kvs: [A:B]) -> [A:B] {
  return merge([kv.0 : kv.1], kvs)
}

func fromArray <A: Hashable, B> (xs: [(A, B)]) -> [A:B] {
  return reduce(xs, [A:B](), merge)
}

/**
 Functor
 */
func fmap <A: Hashable, B: Hashable, C, D> (fk: A -> B, fv: C -> D) -> [A:C] -> [B:D] {
  return {kvs in
    var ret = [B:D]()
    for (k, v) in kvs {
      ret[fk(k)] = fv(v)
    }
    return ret
  }
}

func fmap<A: Hashable, B: Hashable, C, D> (f: (A -> B, C -> D)) -> [A:C] -> [B:D] {
  return fmap(f.0, f.1)
}

func fmap <A: Hashable, B, C> (f: B -> C) -> [A:B] -> [A:C] {
  return fmap(identity, f)
}

/**
 Monad
*/
func bind <A: Hashable, B: Hashable, C, D> (kvs: [A:C], f: (A, C) -> [B:D]) -> [B:D] {
  return reduce(kvs.keys, [B:D]()) { acc, k in
    let v = kvs[k] as C
    return merge(acc, f(k, v))
  }
}
