//
//  Debouncer.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © 2020 {{cookiecutter.company_name}}. All rights reserved.
//

import Foundation

public class Debouncer {
    private let delay: TimeInterval
    private var workItem: DispatchWorkItem?

    public init(delay: TimeInterval) {
        self.delay = delay
    }

    public func run(action: @escaping () -> Void) {
        workItem?.cancel()
        workItem = DispatchWorkItem(block: action)
        if let item = workItem {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: item)
        }
    }
    
    deinit {
        printDeinit(self)
    }
}
