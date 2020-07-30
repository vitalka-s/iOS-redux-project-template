//
//  SplashPresenter.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © 2020 {{cookiecutter.company_name}}. All rights reserved.
//

struct SplashPresenter {
    typealias Props = SplashViewController.Props
    
    let render: CommandWith<Props>
    let dispatch: CommandWith<Action>
    let endObserving: Command
    
    func present(state: AppState) {
        render.perform(
            with: .init(
                onDestroy: endObserving
            )
        )
    }
}
