//
//  AppStateSpec.swift
//  {{cookiecutter.app_name}}Tests
//
//  Copyright © 2020 {{cookiecutter.company_name}}. All rights reserved.
//

@testable import {{cookiecutter.app_name}}
import Quick
import Nimble

class AppStateSpec: QuickSpec {
    override func spec() {
        var state: AppState!
        beforeEach {
            state = .initial
        }
        
        describe("reducer") {            
            context("app initialization action action") {
                it("state should be set to initial.") {
                    let expected = state
                    let received = reduce(state, AppInitializationAction())
                    expect(received).to(equal(expected))
                }
            }
        }
    }
}
