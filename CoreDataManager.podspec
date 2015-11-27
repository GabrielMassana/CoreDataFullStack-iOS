Pod::Spec.new do |s|

  s.name         = "CoreDataManager"
  s.version      = "1.0.0"
  s.summary      = "A static library project that simplifies Core Data."

  s.homepage     = "https://github.com/GabrielMassana"
  s.license      = { :type => 'BSD'}
  s.author       = { "Gabriel Massana" => "gabrielmassana@gmail.com" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/GabrielMassana/CoreDataManager-iOS.git", :tag => s.version, :branch => "master"}

  s.source_files  = "CoreDataManager/**/*.{h,m}"
  s.public_header_files = "CoreDataManager/**/*.{h}"

  s.requires_arc = true

end
