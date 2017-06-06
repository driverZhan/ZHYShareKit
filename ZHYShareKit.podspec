#
#  Be sure to run `pod spec lint ZHYShareKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = 'ZHYShareKit'
  s.version      = '1.0.0'
  s.summary      = 'simple share kit'
  s.homepage     = 'https://github.com/driverZhan/ZHYShareKit'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { 'driverZhan' => 'senyou2012@163.com' }
  s.platform     = :ios, '6.0'
  s.ios.deployment_target = '6.0'

  s.source       = { :git => 'https://github.com/driverZhan/ZHYShareKit.git', :tag => s.version.to_s }

  s.requires_arc = true

  s.source_files = 'ZHYShareView/classes/**/*.{h,m}'

end
