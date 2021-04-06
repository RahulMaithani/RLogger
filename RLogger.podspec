Pod::Spec.new do |spec|
  spec.name         = 'RLogger'
  spec.version      = '0.1.0'
  spec.authors      = { 
    'RahulMaithani' => 'r.maithani12@gmail.com'
  }
  spec.license      = { 
    :type => 'MIT',
    :file => 'LICENSE' 
  }
  spec.homepage     = 'https://github.com/RahulMaithani/RLogger'
  spec.source       = { 
    :git => 'https://github.com/RahulMaithani/RLogger.git', 
    :branch => 'master',
    :tag => spec.version.to_s 
  }
  spec.summary      = 'This is such a logging framework.'
  spec.source_files = '**/*.swift', '*.swift'
  spec.swift_versions = '4.0'
  spec.ios.deployment_target = '13.0'
end