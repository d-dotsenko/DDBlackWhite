# DDBlackWhite

[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat)](https://developer.apple.com/swift)
[![Platform](https://img.shields.io/cocoapods/p/DDBlackWhite.svg?style=flat)](http://cocoapods.org/pods/DDBlackWhite)
[![License](https://img.shields.io/cocoapods/l/DDBlackWhite.svg?style=flat)](http://cocoapods.org/pods/DDBlackWhite)
[![Version](https://img.shields.io/cocoapods/v/DDBlackWhite.svg?style=flat)](http://cocoapods.org/pods/DDBlackWhite)


Make your image black and white

<img src="Info/DDBlackWhite.gif?raw=true" alt="DDBlackWhite" width=320>

## Installation

### CocoaPods

To install `DDBlackWhite` via [CocoaPods](http://cocoapods.org), add the following line to your Podfile:

```
pod 'DDBlackWhite'
```

### Manually

Add `DDBlackWhite` folder to your Xcode project.

## Usage

See the example Xcode project.

### Basic setup

Create the `DDBlackWhite` instance, set the `inputImage` and `brightness` variables. 
Call `getFilteredImage` method and its closure will return the filtered image.

```swift
let blackWhite = DDBlackWhite()
blackWhite.inputImage = image
blackWhite.brightness = 0.8
blackWhite.getFilteredImage { (image) in
// filtered image received
}
```

### Populating the data

```swift
var inputImage: UIImage?
private(set) var outputImage: UIImage?
var brightness: CGFloat // The filter brightness value (0.0 ... 1.0), Default is 0.5

func getFilteredImage(closure: @escaping (UIImage?)->Void)
```

## Requirements

- iOS 9.0
- Xcode 10, Swift 4.2

## License

`DDBlackWhite` is available under the MIT license. See the LICENSE file for more info.
