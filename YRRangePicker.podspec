#
# Be sure to run `pod lib lint YRRangePicker.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YRRangePicker'
  s.version          = '0.1.0'
  s.summary          = '音视频编辑常用的轨道区间选择器.'
  s.swift_version    = '5.0'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
灵敏的操作，支持选取中间或者选取两端。支持实时切换选择模式。
                       DESC

  s.homepage         = 'https://github.com/Yuri/YRRangePicker'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Yuri' => 'xueyongwei@foxmail.com' }
  s.source           = { :git => 'https://github.com/Yuri/YRRangePicker.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'YRRangePicker/Classes/**/*'
  
  # s.resource_bundles = {
  #   'YRRangePicker' => ['YRRangePicker/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
