Pod::Spec.new do |s|
  s.name             = 'XBLogs'
  s.version          = '0.1.0'
  s.summary          = 'A short description of XBLogs.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/LiuSky/XBLogs'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '327847390@q.com' => '327847390@qq.com' }
  s.source           = { :git => 'https://github.com/LiuSky/XBLogs.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.source_files = 'XBLogs/Classes/**/*'
  #s.dependency 'fishhook', '~> 0.2'
end
