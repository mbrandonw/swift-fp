//
//  Monoid.swift
//  swift-fp
//
//  Created by Brandon Williams on 7/19/14.
//  Copyright (c) 2014 Brandon Williams. All rights reserved.
//

import Foundation

protocol Monoid : Semigroup {
  class func mzero () -> Self
}

func mconcat <M: Monoid> (ms: [M]) -> M {
  return ms.reduce(M.mzero(), {$0.op($1)})
}
