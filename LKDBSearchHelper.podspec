 
Pod::Spec.new do |s|
 

  s.name         = "LKDBSearchHelper"
  s.version      = "1.2"
  s.summary      = "LKDBSearchHelper Sample Task....."
 

  s.homepage     = "https://github.com/junhaiyang/LKDBSearchHelper"
 
  s.license      = "MIT"
 
  s.author             = { "yangjunhai" => "junhaiyang@gmail.com" } 
  s.ios.deployment_target = "7.0" 

  s.ios.framework = 'UIKit'
 
  s.source = { :git => 'https://github.com/junhaiyang/LKDBSearchHelper.git' , :tag => '1.2'} 
 
  s.requires_arc = true

  s.source_files = 'LKDBSearchHelper/*.{h,m,mm}'  
   
  s.compiler_flags = '-w'
   
  s.dependency 'LKDBHelper'
 
end
