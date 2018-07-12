Pod::Spec.new do |s|
    s.name         = "CHAuthCodeTextFieldView"
    s.version      = "0.0.1"
    s.summary      = "You can Use CHAuthCodeTextFieldView to build AuthCodeTextFieldView"
    s.homepage     = "https://github.com/MeteoriteMan/CHAuthCodeTextFieldView"
    s.license      = "MIT"
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.author       = { "张晨晖" => "shdows007@gmail.com" }
    s.platform     = :ios
    s.source       = { :git => "https://github.com/MeteoriteMan/CHAuthCodeTextFieldView.git", :tag => s.version }
    s.source_files = 'CHAuthCodeTextFieldView/**/*.{h,m}'
    s.frameworks   = 'Foundation', 'UIKit', 'Masonry'
    s.dependency 'Masonry', '~> 1.1.0'
end