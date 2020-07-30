# iOS-redux-project-template

A template to create a Redux project with common dependencies and configuration. 

## Dependencies:

* [SwiftLint][swiftLint-github] - A tool to enforce Swift style and conventions
* [R.swift][r.swift-github] - Get strong typed, autocompleted resources like images, fonts and segues in Swift projects
* [Quick][nimble-github] - A behavior-driven development framework for Swift and Objective-C.
* [Nimble][nimble-github] - A Matcher Framework for Swift and Objective-C.
* [SwiftyRedux][swifty-redux-github] - A dependency that contains `core` of Redux architecture.
* [Sourcery][sourcery-github] - A code generator for Swift language.
* [Cocoapods integration][cocoapods]
* [Gemfile for managing Cocoapods version][a-gemfile]
* [Standard gitignore][gitignore]

[swiftLint-github]: https://github.com/realm/SwiftLint
[r.swift-github]: https://github.com/mac-cain13/R.swift
[quick-github]: https://github.com/Quick/Quick
[nimble-github]: https://github.com/Quick/Nimble 
[swifty-redux-github]: https://github.com/a-voronov/swifty-redux 
[sourcery-github]: https://github.com/krzysztofzablocki/Sourcery
[cocoapods]: https://cocoapods.org
[a-gemfile]: https://guides.cocoapods.org/using/a-gemfile.html
[gitignore]: https://github.com/github/gitignore/blob/master/Swift.gitignore

## Requirements:
* [Cookiecutter](https://cookiecutter.readthedocs.io/en/latest/installation.html)

```
brew install cookiecutter
```

* [Bundler](https://bundler.io/#getting-started)

```
sudo gem install bundler
```
## Usage:

The project uses Cookiecutter for project templating. To create a new project from this template just run:

```
cookiecutter https://github.com/VitaliySavchenko/iOS-redux-project-template.git
```

The project is using cocoapods for managing external libraries and a Gemfile for managing the cocoapods version. 
After generation project will be run `post_gen_project.sh` which install cocoapods automatically.
