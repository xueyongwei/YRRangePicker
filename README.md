# YRRangePicker

[![CI Status](https://img.shields.io/travis/Yuri/YRRangePicker.svg?style=flat)](https://travis-ci.org/Yuri/YRRangePicker)
[![Version](https://img.shields.io/cocoapods/v/YRRangePicker.svg?style=flat)](https://cocoapods.org/pods/YRRangePicker)
[![License](https://img.shields.io/cocoapods/l/YRRangePicker.svg?style=flat)](https://cocoapods.org/pods/YRRangePicker)
[![Platform](https://img.shields.io/cocoapods/p/YRRangePicker.svg?style=flat)](https://cocoapods.org/pods/YRRangePicker)

## 说明

音视频编辑常用的音轨、画轨上区间选择器。
操作灵敏，支持选择中间、选择两边。

## 示例

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## 集成

YRRangePicker is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'YRRangePicker'
```
## 使用

在需要的地方编码：
```
let picker = YRRangePicker.init(pickType: .outside, frame: CGRect.init(x: 50, y: 100, width: 300, height: 40))
picker.didUpdateRange = { min,max in
    print("min:\(min) , max:\(max)")
}
view.addSubview(picker)
```

## Author

Yuri, xueyongwei@foxmail.com

## License

YRRangePicker is available under the MIT license. See the LICENSE file for more info.
