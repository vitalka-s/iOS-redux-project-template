//
//  Functions.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © 2020 {{cookiecutter.company_name}}. All rights reserved.
//

// swiftlint:disable unavailable_function
func undefined<T>(
    hint: String = "",
    file: StaticString = #file,
    line: UInt = #line
) -> T {
    let message = hint.isEmpty ? "" : ": \(hint)"
    fatalError("undefined \(T.self)\(message)", file: file, line: line)
}
// swiftlint:enable unavailable_function

func cast<Value, Result>(_ value: Value) -> Result? {
    return value as? Result
}
// swiftlint:disable redundant_print_statements
func printInDebug(_ items: Any...) {
    #if DEBUG
    print(items)
    #endif
}

func printDeinit<T>(_ type: T) {
    #if DEBUG
    print("Deinit " + typeString(type))
    #endif
}
// swiftlint:enable redundant_print_statements
func typeString<T>(_ value: T) -> String {
    return typeString(type(of: value))
}

func typeString<T>(_ type: T.Type) -> String {
    return String(describing: type)
}
