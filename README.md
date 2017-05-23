# Overlog

![](https://www.bitrise.io/app/a30519b090279206/status.svg?token=IqUL6pahZ_BKcwqjzfV0dg&branch=develop)
![](https://img.shields.io/badge/swift-3.1-orange.svg)
![](https://img.shields.io/github/release/netguru/Overlog.svg)
![](https://img.shields.io/badge/carthage-compatible-green.svg)
![](https://img.shields.io/badge/cocoapods-compatible-green.svg)

**Overlog** is an overlay for iOS apps that allows individual developers and teams to easier test and debug their apps.

## Installation Requirements

Overlog requires **Xcode 8.3 or higher** and supports **iOS 8.0 or higher**.

## Installation

### Carthage

If you're using [Carthage](https://github.com/Carthage/Carthage), add the following dependency to your `Cartfile`:

```none
github "netguru/Overlog" {version}
```

### CocoaPods

If you're using [CocoaPods](http://cocoapods.org), add the following dependency to your `Podfile`:

```none
use_frameworks!
pod 'Overlog', '~> {version}'
```

## Development

Development requires the following tools to be installed:

- **[Xcode](https://github.com/KrauseFx/xcode-install) 8.3** using the latest **iOS 10.3 SDK**,
- **[Carthage](https://github.com/Carthage/Carthage) 0.23** or higher.

Assuming the above tools are present, clone the repository and install the project's dependencies using Carthage:

```sh
$ carthage bootstrap --platform iOS --cache-builds
```

After that, open `Overlog.xcodeproj` and build the project!

## About

This project is made with <3 by [Netguru](https://netguru.co).

### License

This project is licensed under the MIT License. See [LICENSE.md](LICENSE.md) for more info.
