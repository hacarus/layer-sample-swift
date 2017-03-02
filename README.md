# Layer.com Swift code sample

## Prerequisites

* Xcode 8.2.1
* CocoaPods 1.2.0 ( with Ruby 2.3 )

## Setup Layer.com account

Sign up to Layer.com from [here](https://developer.layer.com/signup). Then, create "Atlas Messanger" in your Layer account from [Atlas Build](https://developer.layer.com/dashboard/atlas/build).

## How to run the project

Install dependent libraries by 

```
pod install
```

Then open the `LayerSample.xcworkspace` like this

```
open -a /Applications/Xcode.app LayerSample.xcworkspace
```

Change `APP_ID` defined in [AppDelegate.swift](https://github.com/hacarus/layer-sample-swift/blob/master/LayerSample/AppDelegate.swift#L14) to the one you can see in your Dashboard. Then, select `Product` and `Run` in Xcode.

You can see the conversation in [Atlas Chat Web Page](https://developer.layer.com/atlas/chat).
