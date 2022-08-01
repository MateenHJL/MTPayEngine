#
# Be sure to run `pod lib lint PayEngine.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PayEngine'
  s.version          = '1.0.2'
  s.summary          = 'A short description of PayEngine.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'payEngine support AliPay and Wechat payment function'

  s.homepage         = 'https://github.com/MateenHJL/MTPayEngine.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = 'Mateen';
  s.source           = { :git => 'https://github.com/MateenHJL/MTPayEngine.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'PayEngine/Classes/**/*'
  
  # s.resource_bundles = {
  #   'PayEngine' => ['PayEngine/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.frameworks = 'CFNetwork', 'CoreMotion', 'CoreGraphics', 'SystemConfiguration', 'CoreText', 'QuartzCore' , 'CoreTelephony'
  s.static_framework = true 
  s.dependency 'WechatOpenSDK'
  s.libraries = 'z', 'sqlite3.0', 'c++'
  s.header_dir = "openssl"
  s.vendored_frameworks = 'PayEngine/Classes/iOS_SDK/AlipaySDK.framework'
  s.vendored_libraries = 'PayEngine/Classes/iOS_SDK/libcrypto.a', 'PayEngine/Classes/iOS_SDK/libssl.a'
   
end
