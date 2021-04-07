# RLogger

RLogger is fast, flexible and lightweight logging for Swift 4 & Swift 5 on iOS which writes log messages to a file and can be used for further tracking of code execution for application/project. RLogger is available under the terms of the MIT license. This Git repository contains the library's Core part. 

## How to get started

First, install RLogger via [CocoaPods](https://cocoapods.org/), [Carthage](https://github.com/Carthage/Carthage) or manually. 

## CocoaPods

```swift
platform :ios, ’13.0’

target 'SampleProject' do
  use_frameworks!
  pod 'RLogger', '0.1.0'
end
```

## Carthage

Carthage is a lightweight dependency manager for Swift and Objective-C. It leverages CocoaTouch modules and is less invasive than CocoaPods.
To install with Carthage, follow the instruction on Carthage
Cartfile

```
github "RahulMaithani/RLogger" ~> 0.2.0
```

## Usage

Usually, you can simply import RLogger.

```swift
import RLogger
let log = RLogger.self
```

## Requirements
The current version of RLogger requires:
* Xcode 12 or later
* Swift 5.3 or later
* iOS 9 or later

## License
**RLogger** is released under the [MIT License](https://github.com/RahulMaithani/RLogger/blob/master/LICENSE).
