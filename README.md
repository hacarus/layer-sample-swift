# Layer.com Swift code sample

( Japanese follows English )

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

Change `APP_ID` defined in [AppDelegate.swift](https://github.com/hacarus/layer-sample-swift/blob/master/LayerSample/AppDelegate.swift#L14) to the one you can see in your Dashboard. Then, select `Product` and `Run` in Xcode. Then you can see the following screen.

![Screenshot](https://cacoo.com/diagrams/8fI0WYalDRJGRHHL-F1F4D.png)

You can also see the conversation in [Atlas Chat Web Page](https://developer.layer.com/atlas/chat).

----

# Layer.com Swift サンプル

メッセージングプラットフォームの [Layer.com](https://layer.com) の Swift のサンプルです。

## 下準備

以下のツール、バージョンで動作を確認しています。

* Xcode 8.2.1
* CocoaPods 1.2.0 ( with Ruby 2.3 )

## Layer.com アカウントの作成

[ここから](https://developer.layer.com/signup) Layer.com のアカウントを作成してください。その後 [Atlas Build](https://developer.layer.com/dashboard/atlas/build) から "Atlas Messanger" アプリを作成した Layer.com のアカウント内につくります。

## サンプルアプリの実行の仕方

依存ライブラリを CocoaPods 経由でインストールします。

```
pod install
```

その後、`LayerSample.xcworkspace` を Xcode で開いてください。コマンドラインでの例は以下の通りです。

```
open -a /Applications/Xcode.app LayerSample.xcworkspace
```

[AppDelegate.swift](https://github.com/hacarus/layer-sample-swift/blob/master/LayerSample/AppDelegate.swift#L14) で定義されている `APP_ID` を Layer.com のダッシュボードから取得できるものに変更してください。その後 `Product` から `Run` を Xcode で選ぶと以下のような画面が見えるようになります。

![Screenshot](https://cacoo.com/diagrams/8fI0WYalDRJGRHHL-F1F4D.png)

会話の内容は [Atlas Chat Web Page](https://developer.layer.com/atlas/chat)で確認することもできます。
