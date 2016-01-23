Pod::Spec.new do |s|

  s.name         = "CoreDataFullStack"
  s.version      = "0.2.0"
  s.summary      = "A static library project that simplifies Core Data."

  s.homepage     = "https://github.com/GabrielMassana"
  s.license      = { :type => 'MIT', :file => 'LICENSE.md'}
  s.author       = { "Gabriel Massana" => "gabrielmassana@gmail.com" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/GabrielMassana/CoreDataFullStack-iOS.git", :tag => s.version, :branch => "master"}

  s.source_files  = "CoreDataFullStack-iOS/**/*.{h,m}"
  s.public_header_files = "CoreDataFullStack-iOS/**/*.{h}"

  s.requires_arc = true

end
