swift-fp
========

This is mostly a test environment for experimenting with how hard Swift can be pushed towards some of my favorite things about fp.

Examples
========

## Num

Created a `Num` typeclass and made all the native numeric types extend it. Now we can do things like:

```swift
func square <A: Num> (x: A) -> A {
  return x.multiply(x)
}

square(5)   //=> 25
square(1.5) //=> 2.25
```

without worrying if we are dealing with an `Int`, `Float` or `UInt8`. We also overloaded `+` and `*` for partial application so that we can do things like:

```swift
let xs = [1, 1, 2, 3, 5, 8]
map(xs, *3) //=> [3, 3, 6, 9, 15, 24]
```

And of course in the future if we had `Vector`, `Matrix`, etc... types we could extend those classes to adopt `Num`.

## Combinators

We've implemented a few basic function combinators:

```
// function composition
(sqrt * sin)(3.0) //=> 0.375659...

// left associative pipe
4.0 |> sqrt //=> 2.0

// right associative pipe
tan <| 3.1415 //=> -.000092...
```

## Functor, Monad, Applicative

We don't have the real versions of these things, but I've implemented the necessary functions to make them act like the corresponding typeclasses. For example:

```swift
func square (x: Int) -> Int {
  return x * x
}

func halfInt (x: Int) -> Int? {
  if x % 2 == 0 {
    return x / 2
  }
  return nil
}

square(halfInt(20))  // doesn't work
square(halfInt(20)!) // works, but not safe
square(halfInt(21)!) // crash!

// completely safe
fmap(square)(halfInt(20)) //=> {Some 100}
fmap(square)(halfInt(21)) //=> {None}

// or using our combinators
20 |> halfInt |> fmap(square)
```

## Set

An implementation of a set. Not really happy with it, but it's there.

## Futures

Haven't pushed this yet, but getting close to a nice implementation.



