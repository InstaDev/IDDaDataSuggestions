Pod::Spec.new do |s|
  s.name             = "IDDaDataSuggestions"
  s.version          = "0.1.0"
  s.summary          = "Loads suggestions via dadata.ru API."
  s.description      = <<-DESC
                       Use dadata.ru API to load suggestions

                       * Support all methods address/party/fio
                       * Support all parameters from http://confluence.hflabs.ru/display/SGTDOC47/API
                       DESC
  s.homepage         = "https://github.com/instadev/IDDaDataSuggestions"
  s.license          = 'MIT'
  s.author           = { "4tune" => "sotskiy@gmail.com" }
  s.source           = { :git => "https://github.com/instadev/IDDaDataSuggestions.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'IDDaDataSuggestions' => ['Pod/Assets/*.png']
  }

  s.dependency 'AFNetworking', '~> 2.0'
end
