//
//  SplashViewController.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © 2020 {{cookiecutter.company_name}}. All rights reserved.
//

import UIKit

extension SplashViewController {
    func setupUI() {
    }
}

extension SplashViewController.Props: Equatable, AutoCodable {}
final class SplashViewController: UIViewController {
    struct Props {
        let onDestroy: Command
        
        static let initial: Props = .init(
            onDestroy: .nop
        )
    }
    
    private var props: Props = .initial

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func render(_ props: Props) {
        self.props = props
    }
    
    deinit {
        self.props.onDestroy.perform()
        printDeinit(self)
    }
}
