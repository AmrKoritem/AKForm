Pod::Spec.new do |s|

s.name = "AKForm"
s.summary = "AKForm is a form generator for swift projects."
s.requires_arc = true

s.version = "0.2.0"
s.license = { :type => "MIT", :file => "LICENSE" }
s.author = { "Amr Koritem" => "amr.koritem92@gmail.com" }
s.homepage = "https://github.com/AmrKoritem/AKForm"
s.source = { :git => "https://github.com/AmrKoritem/AKForm.git",
             :tag => "v#{s.version}" }

s.framework = "UIKit"
s.source_files = "Sources/AKForm/**/*.{swift}"
s.resources = "Sources/AKForm/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"
s.swift_version = "5.0"
s.ios.deployment_target = '13.0'

end
