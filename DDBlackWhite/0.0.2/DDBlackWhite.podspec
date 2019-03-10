Pod::Spec.new do |spec|

	spec.name 		= "DDBlackWhite"
	spec.platform 		= :ios
	spec.summary 		= "DDBlackWhite allows a user to make his image black and white"
	spec.requires_arc 	= true
	spec.version 		= "0.0.2"
	spec.license 		= { :type => "MIT", :file => "LICENSE" }	
	spec.author 		= { "Dmitriy Dotsenko" => "d.dotsenko@icloud.com" }
	spec.homepage 		= "https://github.com/d-dotsenko/DDBlackWhite"
	spec.source 		= { :git => "https://github.com/d-dotsenko/DDBlackWhite.git", :tag => "#{spec.version}" }
	spec.frameworks 	= "UIKit"
	spec.source_files 	= "DDBlackWhite/**/*.{h,swift}"
	spec.swift_version 	= "4.2"
	spec.ios.deployment_target 	= "9.0"
end
