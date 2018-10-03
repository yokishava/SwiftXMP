# SwiftXMP

[![Build Status](https://travis-ci.org/2takaanthony85/SwiftXMP.svg?branch=master)](https://travis-ci.org/2takaanthony85/SwiftXMP)

SwiftXMP is able to add your custom scheme XMP to jpeg file.

## Features

SwiftXMP is able to add your custom scheme XMP (Extensible Metadata Platform) to jpeg file.

It is possible to write XMP on a APP1 segment without erase APP1 segemnet of Exif.

## Requirements

* iOS 10.0 or later

## Installtion

### cocoaPods

You want to add ```pod 'SwiftXMP', '~> 0.0'``` similar to the following to your Podfile:

```
target 'MyApp' do
  pod 'SwiftXMP', '~> 0.0'
end
```

Then run a ```pod install``` inside your terminal, or from CocoaPods.app.

Alternatively to give it a test run, run the command:

```pod try SwiftXMP```

### carthage

insert following script to your Cartfile:

```github "2takaanthony85/SwiftXMP"```

run ```carthage update```


## How to use



## License

SwiftXMP is released under the MIT license. Go read the LICENSE file for more information.
