//
//  StoreLocator.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © 2020 {{cookiecutter.company_name}}. All rights reserved.
//

enum StoreLocator {
    static var shared: Store<AppState> {
        guard let instance = instance else { fatalError("Store not populated") }
        return instance
    }
    
    private static var instance: Store<AppState>?
    
    static func populate(instance: Store<AppState>) {
        self.instance = instance
    }
}
