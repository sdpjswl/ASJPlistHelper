Pod::Spec.new do |s|
  s.name          = 'ASJPlistHelper'
  s.version       = '0.3'
  s.platform      = :ios, '9.0'
  s.license       = { :type => 'MIT' }
  s.homepage      = 'https://github.com/sdpjswl/ASJPlistHelper'
  s.authors       = { 'Sudeep' => 'sdpjswl1@gmail.com' }
  s.summary       = 'Simplify working with property lists'
  s.source        = { :git => 'https://github.com/sdpjswl/ASJPlistHelper.git', :tag => s.version }
  s.source_files  = 'ASJPlistHelper/*.{h,m}'
  s.requires_arc  = true
end
