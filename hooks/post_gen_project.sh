#!/bin/sh

set -e

bundle install
bundle exec pod install
Pods/Sourcery/bin/sourcery --sources ./{{cookiecutter.app_name}} --templates ./{{cookiecutter.app_name}}/Resources/Sourcery/Templates --output ./{{cookiecutter.app_name}}/Resources/Generated
