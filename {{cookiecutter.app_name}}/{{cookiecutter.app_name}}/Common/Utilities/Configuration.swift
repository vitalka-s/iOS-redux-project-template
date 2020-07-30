//
//  Configuration.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © {{cookiecutter.company_name}}. All rights reserved.
//

import Foundation

extension ConfigurationsList: Decodable {
    private enum CodingKeys: String, CodingKey {
        case debug = "Debug"
        case release = "Release"
        case staging = "Staging"
    }
}

private struct ConfigurationsList {
    let debug: Configuration.Option
    let release: Configuration.Option
    let staging: Configuration.Option

    static func decodeConfiguration() -> ConfigurationsList? {
        return Bundle.main.url(forResource: "Configuration", withExtension: "plist")
        .flatMap { try? Data(contentsOf: $0) }
        .flatMap { try? PropertyListDecoder().decode(ConfigurationsList.self, from: $0) }
    }
}

extension Configuration.Option: Decodable {}
enum Configuration {
    private enum ActiveSystemConfiguration: String {
        case debug = "Debug"
        case release = "Release"
        case staging = "Staging"
    }
    
    struct Option {
        let baseURL: String
    }
    
    static let current: Option = {
        guard let list = configurationsList else { fatalError("No configuration") }
        switch activeSystemConfiguration {
        case .debug:
            return list.debug
        case .release:
            return list.release
        case .staging:
            return list.staging
        }
    }()
    
    private static let configurationsList: ConfigurationsList? = {
        ConfigurationsList.decodeConfiguration()
    }()
    
    private static let activeSystemConfiguration: ActiveSystemConfiguration = {
        guard
            let rawConfiguration = Bundle.main
                .object(forInfoDictionaryKey: "Configuration") as? String,
            let activeConfiguration = ActiveSystemConfiguration(rawValue: rawConfiguration)
            else { fatalError("No configuration") }
        switch activeConfiguration {
        case .debug:
            return .debug
        case .release:
            return .release
        case .staging:
            return .staging
        }
    }()
}
