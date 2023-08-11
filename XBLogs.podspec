#
# Be sure to run `pod lib lint XBLogs.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XBLogs'
  s.version          = '0.1.0'
  s.summary          = 'A short description of XBLogs.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/327847390@q.com/XBLogs'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '327847390@q.com' => '327847390@qq.com' }
  s.source           = { :git => 'https://github.com/327847390@q.com/XBLogs.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.source_files = 'XBLogs/Classes/**/*'
  #s.dependency 'fishhook', '~> 0.2'
end
