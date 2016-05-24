Pod::Spec.new do |s|
  s.name          = 'ASJPlistHelper'
  s.version       = '0.2'
  s.platform      = :ios, '7.0'
  s.license       = { :type => 'MIT' }
  s.homepage      = 'https://github.com/sudeepjaiswal/ASJPlistHelper'
  s.authors       = { 'Sudeep Jaiswal' => 'sudeepjaiswal87@gmail.com' }
  s.summary       = 'Simplify working with property lists'
  s.source        = { :git => 'https://github.com/sudeepjaiswal/ASJPlistHelper.git', :tag => s.version }
  s.source_files  = 'ASJPlistHelper/*.{h,m}'
  s.requires_arc  = true
end
