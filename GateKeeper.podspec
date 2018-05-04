Pod::Spec.new do |s|
  s.name             = 'GateKeeper'
  s.version          = '0.2.1'
  s.summary          = 'Plug and Play TouchId/FaceId Authenticator for your app'
 
  s.description      = <<-DESC
Plug and Play TouchId/FaceId Authenticator for your app!
                       DESC
 
  s.homepage         = 'https://github.com/ahujamanish/gatekeeper'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Manish Ahuja' => 'itsme.manish@gmail.com' }
  s.source           = { :git => 'https://github.com/ahujamanish/gatekeeper.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '11.0'
  s.source_files = 'GateKeeper/Source/*.swift'
  s.resources = 'GateKeeper/Source/*.{xib,storyboard,xcassets}'
 
end