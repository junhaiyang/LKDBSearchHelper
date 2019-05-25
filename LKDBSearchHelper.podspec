 
Pod::Spec.new do |s|
 

  s.name         = "LKDBSearchHelper"
  s.version      = "2.0"
  s.summary      = "ORM-style SQL builder for LKDBHelper"
  s.homepage     = "https://github.com/junhaiyang/LKDBSearchHelper" 
  s.license      = "MIT"
 
  s.author             = { "yangjunhai" => "junhaiyang@gmail.com" } 
  s.ios.deployment_target = "7.0" 
 
  s.source = { :git => 'https://github.com/junhaiyang/LKDBSearchHelper.git' , :tag => '2.0'} 
 
  s.requires_arc = true

  s.source_files = 'LKDBSearchHelper/**/*.{h,m,mm}'  
   
  s.compiler_flags = '-w'
   
  s.dependency 'LKDBHelper'
 
end
