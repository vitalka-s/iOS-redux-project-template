//
//  Optional.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © 2020 {{cookiecutter.company_name}}. All rights reserved.
//

public extension Optional {
    func apply<Result>(_ transform: ((Wrapped) -> Result)?) -> Result? {
        return self.flatMap { value in
            transform.map { $0(value) }
        }
    }
    
    func apply<Value, Result>(_ value: Value?) -> Result? where Wrapped == (Value) -> Result {
        return value.apply(self)
    }
    
    func flatten<Result>() -> Result? where Wrapped == Result? {
        return self.flatMap { $0 }
    }
    
    func `do`(_ action: (Wrapped) -> Void) {
        self.map(action)
    }
}
