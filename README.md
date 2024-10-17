# Embedded Provision

Handy helpers for reading values from an applications embedded provision profiles.


<!-- TOC ignore:true -->
## Quick Start

... TBD ...

## Table of Contents




## Installation

### CocoaPods

To install MagicBell using [CocoaPods](https://cocoapods.org), add this entry to your `Podfile`:

```ruby
pod 'EmbeddedProvision', '>=0.0.0'
```

**IMPORTANT**: Make sure you specify `use_frameworks!` in your `Podfile`.

Then, run `pod install`.

### Swift Package Manager

To install the library using [Swift Package Manager](https://www.swift.org/package-manager/), just add the dependency as follows to your project:

```swift
dependencies: [
    .package(url: "https://github.com/magicbell/embedded-provision", .upToNextMajor(from: "0.0.0"))
]
```

### Carthage

To install the library using [Carthage](https://github.com/Carthage/Carthage), add the following dependency to the Carfile :

```ruby
github "magicbell/embedded-provision" "0.0.0"
```

Then, run `carthage update --use-xcframeworks --platform [iOS|macOS] --no-use-binaries` (selecting the desired platform) to resolve dependencies.

Add the `EmbeddedProvision.xcframework` to your project-linked frameworks, together with the other dependencies resolved by Carthage.

## FAQ

### What is an embedded provision?

### Does this library support macOS?

It might. It wasn't tested though. [PRs are welcome](./CONTRIBUTING.md).

## Contributing

[Contributions of any kind are welcome.](./CONTRIBUTING.md)
