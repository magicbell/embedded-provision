# Embedded Provision

[![Version](https://img.shields.io/cocoapods/v/EmbeddedProvision.svg?style=flat)](http://cocoapods.org/pods/embeddedprovision)
[![License](https://img.shields.io/cocoapods/l/EmbeddedProvision.svg?style=flat)](./LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/EmbeddedProvisiog.svg?style=flat)](http://cocoapods.org/pods/embeddedprovision)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/magicbell/embedded-provision?tab=readme-ov-file#carthage)
[![SwiftPM compatible](https://img.shields.io/badge/SwiftPM-compatible-brightgreen.svg)](https://github.com/magicbell/embedded-provision?tab=readme-ov-file#swift-package-manager)
[![Swift Tests](https://github.com/magicbell/embedded-provision/actions/workflows/spm-test.yml/badge.svg)](https://github.com/magicbell/embedded-provision/actions/workflows/spm-test.yml)

✨ Handy helpers for reading values from an applications embedded provision profile.

Embedded provision profiles can answer many questions about where and how an iOS or macOS application is running, like:
- Is this app deployed to the AppStore or distributed internally?
- Which push notification environment is the application signed for?
- What's the Apple developer team ID that was used to sign the app?

... and more!


## Quick Start

You can take a look at the provided example project, or simply play with yourself.

```swift
import EmbeddedProvision

do {
  if let provision = try EmbeddedProvision.load() {
    print("Your app was signed with \(provision.name).")
  } else {
    print("Your app is likely running in a Simulator right now.")
  }
}
catch EmbeddedProvisionError.decodingError {
  fatalError("Decoding errors should not happen. Please file an issue.")
}
catch {
  fatalError("Generally errors are very unexpected, and so is this: \(error) ")
}
```

## Table of Contents

<!-- TOC -->

- [Quick Start](#quick-start)
- [Table of Contents](#table-of-contents)
- [API](#api)
    - [Properties](#properties)
    - [Entitlements](#entitlements)
- [Installation](#installation)
    - [CocoaPods](#cocoapods)
    - [Swift Package Manager](#swift-package-manager)
    - [Carthage](#carthage)
- [FAQ](#faq)
    - [What is an embedded provision profiles?](#what-is-an-embedded-provision-profiles)
    - [Why is there no provision profile embedded in my app?](#why-is-there-no-provision-profile-embedded-in-my-app)
    - [Does this library support macOS?](#does-this-library-support-macos)
- [Contributing](#contributing)

<!-- /TOC -->

## API

You can load your applications embedded provisioning profile by using `EmbeddedProvision.load()`. This will look for the profile inside your apps bundle under `embedded.mobileprovision` (on iOS) or `Contents/embedded.provisionprofile` (on macOS).

### Properties

Once you have an instance of `EmbeddedProvision` at hand you have access to the following properties that are more about describing the profile itself:

| Property         | Signature      | Discussion                                                              |
| ---------------- | -------------- | ----------------------------------------------------------------------- |
| `name`           | `String`       | The name of the profile that was used to sign your app                  |
| `appIDName`      | `String`       | The name of the app ID (as provided in the developer portal)            |
| `platform`       | `[String]`     | A list of supported platforms (i.e. `iOS`, `visionOS`, `xrOS` and more) |
| `isXcodeManaged` | `Bool?`        | Wether the profile is managed by Xcode                                  |
| `creationDate`   | `Date`         | When the profile was created                                            |
| `expirationDate` | `Date`         | When the profile will expire                                            |
| `entitlements`   | `Entitlements` | The actual content of the profile. See the below.                       |


### Entitlements

Apple supports [a lot of different entitlements](https://developer.apple.com/documentation/bundleresources/entitlements). This library is at the moment only decoding a minimum of them. If you need any other entitlement, please add it and [open a PR](#contributing).

| Entitlement            | Signature         | Discussion                                                                                                          |
| ---------------------- | ----------------- | ------------------------------------------------------------------------------------------------------------------- |
| `keychainAccessGroups` | `[String]`        | A list of application IDs (including wildcards) of keychains this app can access                                    |
| `getTaskAllow`         | `Bool`            | Wether a debugger can attach to the running app. Should be `false` for distributed builds                           |
| `apsEnvironment`       | `APSEnvironment?` | If the app supports push notifications, this property tells you which APNs (formerly APS) environment to use        |
| `teamId`               | `String`          | The identifier of the developer team this app was signed for. This impacts i.e. which APNs push keys should be used |


## Installation

### CocoaPods

To install MagicBell using [CocoaPods](https://cocoapods.org), add this entry to your `Podfile`:

```ruby
pod 'EmbeddedProvision', '>=1.0.0'
```

**IMPORTANT**: Make sure you specify `use_frameworks!` in your `Podfile`.

Then, run `pod install`.

### Swift Package Manager

To install the library using [Swift Package Manager](https://www.swift.org/package-manager/), just add the dependency as follows to your project:

```swift
dependencies: [
    .package(url: "https://github.com/magicbell/embedded-provision", .upToNextMajor(from: "1.0.0"))
]
```

### Carthage

To install the library using [Carthage](https://github.com/Carthage/Carthage), add the following dependency to the Carfile :

```ruby
github "magicbell/embedded-provision" "1.0.0"
```

Then, run `carthage update --use-xcframeworks --platform [iOS|macOS] --no-use-binaries` (selecting the desired platform) to resolve dependencies.

Add the `EmbeddedProvision.xcframework` to your project-linked frameworks, together with the other dependencies resolved by Carthage.

## FAQ

### What is an embedded provision profiles?

I short, they are Apples way to allow your app to run on their platforms. They are a codesigned definition of where you're app can run, what it can do. But nobody explains it better than Applie itself in 
[TN3125 - Provisioning profile fundamentals](https://developer.apple.com/documentation/technotes/tn3125-inside-code-signing-provisioning-profiles#Provisioning-profile-fundamentals).

### Why is there no provision profile embedded in my app?

If the app is not signed to run on a device, there won't be a profile. This typically happens when the app is running in a Simulator.

### Does this library support macOS?

It should! It wasn't extensively tested though. Please [file an issue](https://github.com/magicbell/embedded-provision/issues/new) if you run into any problems.

## Contributing

[Contributions of any kind are welcome.](./CONTRIBUTING.md)
