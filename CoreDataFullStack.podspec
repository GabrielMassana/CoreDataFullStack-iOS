Pod::Spec.new do |s|

  s.name         = "CoreDataFullStack"
  s.version      = "0.3.2"
  s.summary      = "Easiest way to build a Core Data full stack. With Table and Collection View FRC. With easy Deletion, Retrieve and Count."

  s.homepage     = "https://github.com/GabrielMassana"
  s.license      = { :type => 'MIT', :file => 'LICENSE.md'}
  s.author       = { "Gabriel Massana" => "gabrielmassana@gmail.com" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/GabrielMassana/CoreDataFullStack-iOS.git", :tag => s.version, :branch => "master"}

  s.source_files  = "CoreDataFullStack-iOS/**/*.{h,m}"
  s.public_header_files = "CoreDataFullStack-iOS/**/*.{h}"

  s.requires_arc = true

end
