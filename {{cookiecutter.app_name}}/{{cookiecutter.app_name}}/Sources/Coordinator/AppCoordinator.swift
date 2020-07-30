//
//  AppCoordinator.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © 2020 {{cookiecutter.company_name}}. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
    private let window: UIWindow
    private weak var rootController: UIViewController?
    private lazy var spash: SplashViewController = {
        let output = SplashScreenFactory.Output()
        return SplashScreenFactory().default(output)
    }()
    
    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let rootController = spash
        window.rootViewController = rootController
        self.rootController = rootController
    }
    
    deinit {
        printDeinit(self)
    }
}
