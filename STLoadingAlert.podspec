Pod::Spec.new do |s|
  s.name         = "STLoadingAlert"
  s.version      = "0.0.3"
  s.summary      = "Simple loading, prompt dialog box."
  s.homepage     = "https://github.com/YST9527/STLoadingAlert"
  s.license      = "MIT"
  s.author       = { "尹思同" => "yinsitong9527@163.com" }
  s.source       = { :git => "https://github.com/YST9527/STLoadingAlert.git", :tag => s.version}
  s.source_files = "STLoadingAlert/*"
  s.resource  = "loading_imgBlue_78x78.png"
  s.requires_arc = true
  s.platform     = :ios, '7.0'

end
