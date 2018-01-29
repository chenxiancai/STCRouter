Pod::Spec.new do |s|
  s.name         = 'STCRouter'
  s.summary      = '基于标准URL实现的iOS路由系统，可实现业务模块组件化，解耦各个业务模块, 可实现native降级为hybrid。'
  s.version      = '1.2.0'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { 'chenxiancai' => 'chenxiancai@hotmail.com' }
  s.homepage     = 'https://github.com/chenxiancai/STCRouter'

  s.ios.deployment_target = '8.0'

  s.source       = { :git => 'https://github.com/chenxiancai/STCRouter.git', :tag => s.version }
  
  s.source_files = "Router/STCRouter/*.{h,m,c}"
  s.requires_arc = true
  
  s.frameworks = 'Foundation','UIKit'

end
