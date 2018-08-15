#
#  Be sure to run `pod spec lint SGNetworkService.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "SGNetworkService"
  s.version      = "0.0.1"
  s.summary      = "AFNetworking+YYModel的结合，提供网络接口服务自动解析model功能."
  s.description  = <<-DESC
                      "网络库"
                   DESC
  s.homepage     = "https://github.com/wangpo/SGNetworkService.git"
  s.author             = { "wangpo" => "wangpo1987718@163.com" }
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/wangpo/SGNetworkService.git", :tag => "#{s.version}" }
  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.frameworks = 'UIKit', 'Foundation'
  s.requires_arc = true
  s.dependency "AFNetworking"
  s.dependency "YYKit"
end
