//
//  AppDelegate.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © {{cookiecutter.company_name}}. All rights reserved.
//

import UIKit
import Rswift

struct ApplicationMode {
    static let release = ApplicationMode(appState: .initial, navigationInDebug: false)
    static let debug = ApplicationMode(appState: .debug, navigationInDebug: true)
    static let stateDebug = ApplicationMode(appState: .debug, navigationInDebug: false)
    static let navigationDebug = ApplicationMode(appState: .initial, navigationInDebug: true)
    
    let appState: AppState
    let navigationInDebug: Bool
}
// swiftlint:disable required_deinit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var activeCoordinator: Coordinator?
    private let mode = ApplicationMode.stateDebug
    private lazy var store: Store<AppState> = {
        .init(
            state: mode.appState,
            reducer: reduce,
            middleware: [
                loggerMiddleware,
            ]
        )
    }()
    
    // swiftlint:disable discouraged_optional_collection
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        StoreLocator.populate(instance: store)
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window
        
        // Start app
        startApp(debug: mode.navigationInDebug)
        validateResources()
        return true
    }
    // swiftlint:enable discouraged_optional_collection
    
    private func startApp(debug: Bool = false) {
        guard let window = self.window else {
            assertionFailure("Window is nil")
            return
        }
        if debug {
            goToDebug(window)
        } else {
            let appCoordinator = AppCoordinator(window: window)
            appCoordinator.start()
            self.activeCoordinator = appCoordinator
        }
    }
    
    private func goToDebug(_ window: UIWindow) {
        window.rootViewController = UIViewController()
    }
    
    private func validateResources() {
        #if DEBUG
        do {
            try R.validate()
        } catch {
            if let error = error as? Rswift.ValidationError {
                assertionFailure(error.description)
            }
        }
        #endif
    }
}
// swiftlint:enable required_deinit
