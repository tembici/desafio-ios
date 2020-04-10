platform :ios, '11.0'

RxSwiftVersion = '4.4.2'

target 'Desafio' do
  use_frameworks!

  # Networking Pods
  pod 'Alamofire',              '~> 4.7.3'
  pod 'AlamofireImage'

  # UI/UX Pods  
  pod 'SnapKit',                '~> 4.2.0'
  pod 'IQKeyboardManagerSwift', '~> 6.0.4'
  pod 'SpringIndicator',        '~> 4.0.0'
  pod 'SwipeCellKit'

  # Utilities
  pod 'R.swift',                '~> 5.0.3'  
  pod 'StatefulViewController', '~> 3.0'
  pod 'SwiftLint',              '~> 0.37'
  pod 'RealmSwift'
  pod "RxRealm"

  # Rx Pods
  pod 'RxSwift',                "~> #{RxSwiftVersion}"
  pod 'RxCocoa',                "~> #{RxSwiftVersion}"  
  pod 'RxDataSources',         	'~> 3.1.0'
  pod 'RxSwiftExt'
  pod 'RxSwiftUtilities',       :git => 'https://github.com/RxSwiftCommunity/RxSwiftUtilities', :branch => 'master'
  pod "RxGesture"


  target 'DesafioTests' do
      inherit! :search_paths
      pod 'Nimble',         '~> 7.3.4'
      pod 'Quick',          '~> 1.3.4'
      pod 'RxNimble', subspecs: ['RxBlocking', 'RxTest']      
  end

end

pre_install do |installer|
  installer.analysis_result.specifications.each do |s|
    s.swift_version = '4.2' unless s.swift_version
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
    end
  end
end
