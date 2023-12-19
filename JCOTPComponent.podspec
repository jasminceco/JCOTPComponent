Pod::Spec.new do |spec|
spec.name                  = "JCOTPComponent"
spec.version               = "1.0.0"
spec.summary               = "JCOTPComponent"
spec.description           = "JCOTPComponent"
spec.homepage              = 'https://github.com/jasminceco/JCOTPComponent'
spec.license               = { :type => 'MIT', :file => 'LICENSE' }
spec.author                = { 'jasmin.ceco@gmail.com' => 'jasmin.ceco@gmail.com' }
spec.source                = { :git => 'https://github.com/jasminceco/JCOTPComponent.git', :tag => spec.version.to_s }
spec.ios.deployment_target = '14.0'
spec.source_files          = "JCOTPComponent/Source/**/*.{swift}"
spec.swift_version         = '5.0'
spec.requires_arc          = true
spec.platforms             = { "ios": "14.0" }
end
  