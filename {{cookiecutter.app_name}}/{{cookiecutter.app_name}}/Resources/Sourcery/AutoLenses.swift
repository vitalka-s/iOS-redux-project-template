//
//  AutoLenses.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © {{cookiecutter.company_name}}. All rights reserved.
//

import Foundation

// swiftlint:disable all
protocol AutoLenses {}

infix operator *~: MultiplicationPrecedence
infix operator |>: AdditionPrecedence

func |> <A, B> (x: A, f: (A) -> B) -> B {
    return f(x)
}

func |> <A, B, C> (f: @escaping (A) -> B, g: @escaping (B) -> C) -> (A) -> C {
    return { g(f($0)) }
}

func * <A, B, C> (lhs: Lens<A, B>, rhs: Lens<B, C>) -> Lens<A, C> {
    return Lens<A, C>(
        get: { a in rhs.get(lhs.get(a)) },
        set: { (c, a) in lhs.set(rhs.set(c, lhs.get(a)), a) }
    )
}

func *~ <A, B> (lhs: Lens<A, B>, rhs: B) -> (A) -> A {
    return { a in lhs.set(rhs, a) }
}

// MARK: - Either
enum Either<Left, Right> {
    case left(Left)
    case right(Right)
}

// MARK: - Lens
struct Lens<Whole, Part> {
    let get: (Whole) -> Part
    let set: (Part, Whole) -> Whole
}

extension Lens {
    init(_ keyPath: WritableKeyPath<Whole, Part>) {
        get = { whole in whole[keyPath: keyPath] }
        set = { newPart, whole in
            var whole = whole
            whole[keyPath: keyPath] = newPart
            return whole
        }
    }
}

extension Lens {
    func modify(_ transform: @escaping (Part) -> Part) -> (Whole) -> Whole {
        return { whole in
            self.set(transform(self.get(whole)), whole)
        }
    }
}

extension Lens {
    static func zip<Part1, Part2>(
        _ lens1: Lens<Whole, Part1>,
        _ lens2: Lens<Whole, Part2>
        ) -> Lens<Whole, (Part1, Part2)> where Part == (Part1, Part2) {
        return Lens<Whole, (Part1, Part2)>(
            get: { whole in (lens1.get(whole), lens2.get(whole)) },
            set: { parts, whole in lens2.set(parts.1, lens1.set(parts.0, whole)) }
        )
    }
    
    static func zip<Part1, Part2, Part3>(
        _ lens1: Lens<Whole, Part1>,
        _ lens2: Lens<Whole, Part2>,
        _ lens3: Lens<Whole, Part3>
    ) -> Lens<Whole, (Part1, Part2, Part3)> where Part == (Part1, Part2, Part3) {
        return Lens<Whole, (Part1, Part2, Part3)>(
            get: { whole in
                (lens1.get(whole),
                 lens2.get(whole),
                 lens3.get(whole))
        },
            set: { parts, whole in
                lens3
                    .set(parts.2, lens2
                        .set(parts.1, lens1
                            .set(parts.0, whole)))
        }
        )
    }
    
    static func zip<Part1, Part2, Part3, Part4>(
        _ lens1: Lens<Whole, Part1>,
        _ lens2: Lens<Whole, Part2>,
        _ lens3: Lens<Whole, Part3>,
        _ lens4: Lens<Whole, Part4>
    ) -> Lens<Whole, (Part1, Part2, Part3, Part4)> where Part == (Part1, Part2, Part3, Part4) {
        return Lens<Whole, (Part1, Part2, Part3, Part4)>(
            get: { whole in
                (
                    lens1.get(whole),
                    lens2.get(whole),
                    lens3.get(whole),
                    lens4.get(whole)
                )
        },
            set: { parts, whole in
                lens4
                    .set(parts.3, lens3
                        .set(parts.2, lens2
                            .set(parts.1, lens1
                                .set(parts.0, whole))))
        }
        )
    }
    
    static func zip<Part1, Part2, Part3, Part4, Part5>(
        _ lens1: Lens<Whole, Part1>,
        _ lens2: Lens<Whole, Part2>,
        _ lens3: Lens<Whole, Part3>,
        _ lens4: Lens<Whole, Part4>,
        _ lens5: Lens<Whole, Part5>
    ) -> Lens<Whole, (Part1, Part2, Part3, Part4, Part5)> where Part == (Part1, Part2, Part3, Part4, Part5) {
        return Lens<Whole, (Part1, Part2, Part3, Part4, Part5)>(
            get: { whole in
                (
                    lens1.get(whole),
                    lens2.get(whole),
                    lens3.get(whole),
                    lens4.get(whole),
                    lens5.get(whole)
                )
        },
            set: { parts, whole in
                lens5
                    .set(parts.4, lens4
                        .set(parts.3, lens3
                            .set(parts.2, lens2
                                .set(parts.1, lens1
                                    .set(parts.0, whole)))))
        }
        )
    }
    
    static func zip<Part1, Part2, Part3, Part4, Part5, Part6>(
        _ lens1: Lens<Whole, Part1>,
        _ lens2: Lens<Whole, Part2>,
        _ lens3: Lens<Whole, Part3>,
        _ lens4: Lens<Whole, Part4>,
        _ lens5: Lens<Whole, Part5>,
        _ lens6: Lens<Whole, Part6>
    ) -> Lens<Whole, (Part1, Part2, Part3, Part4, Part5, Part6)> where Part == (Part1, Part2, Part3, Part4, Part5, Part6) {
        return Lens<Whole, (Part1, Part2, Part3, Part4, Part5, Part6)>(
            get: { whole in
                (
                    lens1.get(whole),
                    lens2.get(whole),
                    lens3.get(whole),
                    lens4.get(whole),
                    lens5.get(whole),
                    lens6.get(whole)
                )
        },
            set: { parts, whole in
                lens6
                    .set(parts.5, lens5
                        .set(parts.4, lens4
                            .set(parts.3, lens3
                                .set(parts.2, lens2
                                    .set(parts.1, lens1
                                        .set(parts.0, whole))))))
        }
        )
    }
    
    static func zip<Part1, Part2, Part3, Part4, Part5, Part6, Part7>(
        _ lens1: Lens<Whole, Part1>,
        _ lens2: Lens<Whole, Part2>,
        _ lens3: Lens<Whole, Part3>,
        _ lens4: Lens<Whole, Part4>,
        _ lens5: Lens<Whole, Part5>,
        _ lens6: Lens<Whole, Part6>,
        _ lens7: Lens<Whole, Part7>
    ) -> Lens<Whole, (Part1, Part2, Part3, Part4, Part5, Part6, Part7)> where Part == (Part1, Part2, Part3, Part4, Part5, Part6, Part7) {
        return Lens<Whole, (Part1, Part2, Part3, Part4, Part5, Part6, Part7)>(
            get: { whole in
                (
                    lens1.get(whole),
                    lens2.get(whole),
                    lens3.get(whole),
                    lens4.get(whole),
                    lens5.get(whole),
                    lens6.get(whole),
                    lens7.get(whole)
                )
        },
            set: { parts, whole in
                lens7
                    .set(parts.6, lens6
                        .set(parts.5, lens5
                            .set(parts.4, lens4
                                .set(parts.3, lens3
                                    .set(parts.2, lens2
                                        .set(parts.1, lens1
                                            .set(parts.0, whole)))))))
        }
        )
    }
}

extension Lens {
    func compose<Subpart>(_ other: Lens<Part, Subpart>) -> Lens<Whole, Subpart> {
        return Lens<Whole,Subpart>(
            get: { whole in other.get(self.get(whole)) },
            set: { subpart, whole in self.set(other.set(subpart, self.get(whole)), whole) }
        )
    }
}

// MARK: - Prism
struct Prism<Whole, Part> {
    let tryGet: (Whole) -> Part?
    let set: (Part) -> Whole
}

extension Prism {
    func tryModify(_ transform: @escaping (Part) -> Part) -> (Whole) -> Whole {
        return { whole in
            self.tryGet(whole).map { self.set(transform($0)) } ?? whole
        }
    }
}

extension Prism {
    static func zip<Part1, Part2>(
        _ prism1: Prism<Whole, Part1>,
        _ prism2: Prism<Whole, Part2>
        ) -> Prism<Whole, Either<Part1, Part2>> where Part == Either<Part1, Part2> {
        return Prism<Whole, Either<Part1, Part2>>(
            tryGet: { whole in prism1.tryGet(whole).map(Either.left) ?? prism2.tryGet(whole).map(Either.right) },
            set: { part in
                switch part {
                case let .left(value):  return prism1.set(value)
                case let .right(value): return prism2.set(value)
                }
        }
        )
    }
}

extension Prism {
    func compose<Subpart>(_ other: Prism<Part, Subpart>) -> Prism<Whole, Subpart> {
        return Prism<Whole, Subpart>(
            tryGet: { whole in self.tryGet(whole).flatMap(other.tryGet) },
            set: { subpart in self.set(other.set(subpart)) }
        )
    }
}

extension Prism {
    func isCase(_ whole: Whole) -> Bool {
        return tryGet(whole) != nil
    }
}

// MARK: - Affine
struct Affine<Whole, Part> {
    let tryGet: (Whole) -> Part?
    let trySet: (Part, Whole) -> Whole?
}

extension Affine {
    func compose<Subpart>(_ other: Affine<Part, Subpart>) -> Affine<Whole, Subpart> {
        return Affine<Whole, Subpart>(
            tryGet: { whole in self.tryGet(whole).flatMap(other.tryGet) },
            trySet: { subpart, whole in self.tryGet(whole).flatMap { other.trySet(subpart, $0) }.flatMap { self.trySet($0, whole) } }
        )
    }
}

extension Lens {
    var affine: Affine<Whole, Part> {
        return Affine<Whole, Part>(
            tryGet: self.get,
            trySet: self.set
        )
    }
}

extension Prism {
    var affine: Affine<Whole, Part> {
        return Affine<Whole, Part>(
            tryGet: self.tryGet,
            trySet: { part, _ in self.set(part) }
        )
    }
}

// MARK: - Operators
precedencegroup LeftCompositionPrecedence {
    associativity: left
}

infix operator .. : LeftCompositionPrecedence

extension Lens {
    static func .. <Subpart>(lhs: Lens<Whole, Part>, rhs: Lens<Part, Subpart>) -> Lens<Whole, Subpart> {
        return lhs.compose(rhs)
    }
}

extension Prism {
    static func .. <Subpart>(lhs: Prism<Whole, Part>, rhs: Prism<Part, Subpart>) -> Prism<Whole, Subpart> {
        return lhs.compose(rhs)
    }
}

extension Affine {
    static func .. <Subpart>(lhs: Affine<Whole, Part>, rhs: Affine<Part, Subpart>) -> Affine<Whole, Subpart> {
        return lhs.compose(rhs)
    }
}

extension Lens {
    static func .. <Subpart>(lhs: Lens<Whole, Part>, rhs: Affine<Part, Subpart>) -> Affine<Whole, Subpart> {
        return lhs.affine .. rhs
    }
    
    static func .. <Subpart>(lhs: Affine<Whole, Part>, rhs: Lens<Part, Subpart>) -> Affine<Whole, Subpart> {
        return lhs .. rhs.affine
    }
    
    static func .. <Subpart>(lhs: Lens<Whole, Part>, rhs: Prism<Part, Subpart>) -> Affine<Whole, Subpart> {
        return lhs .. rhs.affine
    }
}

extension Prism {
    static func .. <Subpart>(lhs: Prism<Whole, Part>, rhs: Affine<Part, Subpart>) -> Affine<Whole, Subpart> {
        return lhs.affine .. rhs
    }
    
    static func .. <Subpart>(lhs: Affine<Whole, Part>, rhs: Prism<Part, Subpart>) -> Affine<Whole, Subpart> {
        return lhs .. rhs.affine
    }
    
    static func .. <Subpart>(lhs: Prism<Whole, Part>, rhs: Lens<Part, Subpart>) -> Affine<Whole, Subpart> {
        return lhs .. rhs.affine
    }
}
