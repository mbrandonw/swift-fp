//
//  Semigroup.swift
//  swift-fp
//
//  Created by Brandon Williams on 7/19/14.
//  Copyright (c) 2014 Brandon Williams. All rights reserved.
//

import Foundation

protocol Semigroup {
  func op (g: Self) -> Self
}

func op <S: Semigroup> (s: S, t: S) -> S {
  return s.op(t)
}

func opl <S: Semigroup> (s: S) -> S -> S {
  return {t in s.op(t)}
}

func opr <S: Semigroup> (t: S) -> S -> S {
  return {s in s.op(t)}
}

func sconcat <S: Semigroup> (ss: [S]) -> S? {
  if countElements(ss) == 0 {
    return nil
  }
  return ss[1..<ss.count].reduce(ss[0], {$0.op($1)})
}
