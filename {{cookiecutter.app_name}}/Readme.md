# {{cookiecutter.app_name}}

## Dependencies:

The project is using cocoapods for managing external libraries and a Gemfile for managing the cocoapods version.

Get Bundler

```
sudo gem install bundler
```

To install the specific cocoapods version run

```
bundle install
```

Then install the pods

```
bundle exec pod install
```

### Core Dependencies

* Quick - A behavior-driven development framework for Swift and Objective-C.
* Nimble - A Matcher Framework for Swift and Objective-C.
* R.swift - Get strong typed, autocompleted resources like images, fonts and segues in Swift projects
* Swiftlint - A tool to enforce Swift style and conventions.
* SwiftyRedux - A dependency that contains `core` of Redux architecture.
* Sourcery - A code generator for Swift language.
