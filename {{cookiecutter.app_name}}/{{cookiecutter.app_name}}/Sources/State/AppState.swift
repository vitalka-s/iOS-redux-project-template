//
//  AppState.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © 2020 {{cookiecutter.company_name}}. All rights reserved.
//

extension AppState: Equatable, AutoLenses, AutoCodable {}
struct AppState {
    static let initial = AppState()
    static let debug = AppState()
}

func reduce(_ state: AppState, _ action: Action) -> AppState {
    switch action {
    case is AppInitializationAction:
        return .initial
    default:
        return .init()
    }
}
