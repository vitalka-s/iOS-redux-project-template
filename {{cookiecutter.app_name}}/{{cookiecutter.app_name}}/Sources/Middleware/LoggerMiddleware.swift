//
//  LoggerMiddleware.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © 2020 {{cookiecutter.company_name}}. All rights reserved.
//

let loggerMiddleware: Middleware<AppState> = createMiddleware { getState, _, next in { action in
    guard let oldState = getState() else { return }
    printInDebug("[OLD ➡️]: \(oldState)")
    printInDebug("[MSG ✅]: \(action)")
    next(action)
    guard let newState = getState() else { return }
    printInDebug("[NEW ⬅️]: \(newState)\n")
    }
}
