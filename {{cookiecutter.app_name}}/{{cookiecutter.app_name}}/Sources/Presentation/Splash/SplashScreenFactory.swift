//
//  SplashScreenFactory.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © 2020 {{cookiecutter.company_name}}. All rights reserved.
//

import UIKit

extension SplashScreenFactory {
    struct Output {
        static let initial = Output()
    }
}

final class SplashScreenFactory {
    private let store: Store<AppState>
    
    init(store: Store<AppState> = StoreLocator.shared) {
        self.store = store
    }
    
    func `default`(_ output: Output = .initial) -> SplashViewController {
        let controller: SplashViewController = Storyboard.splash.instantiate()
        var disposable: Disposable?
        let endObserving = Command { disposable?.dispose() }
        let dispatcher = CommandWith { [weak store] in store?.dispatch($0) }
        let render = CommandWith { [weak controller] props in
            controller?.render(props)
        }
        
        let presenter = SplashPresenter(
            render: render.dispatched(on: .main),
            dispatch: dispatcher,
            endObserving: endObserving
        )
        disposable = store.subscribeUnique(observer: presenter.present)
        return controller
    }
    
    deinit {
        printDeinit(self)
    }
}
