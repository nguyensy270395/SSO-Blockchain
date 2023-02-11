# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'BaseSwift' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for BaseSwift
  ##RxSwift
  pod 'RxSwift', '6.1.0'
  pod 'RxCocoa', '6.1.0'
  pod 'RxAlamofire','6.1.1'
  pod 'RxDataSources','5.0.0'
  pod 'RxSwiftExt','6.0.1'
  pod 'RxKeyboard'
  pod 'RxReachability', '1.2.1'
  pod 'Action','5.0.0'
  pod 'SwiftLint'
  pod 'Kingfisher', '~> 7.0'
  ##R.Swift
  pod 'R.swift'
  ##FSCalendar
  pod 'FSCalendar'
  ##SwipeMenu
  pod 'SwipeMenuViewController'
  ##Save data
  pod 'KeychainAccess','4.2.2'
  ##local DB
  pod 'RealmSwift','10.15.1'
  ##Keyboard
  pod 'IQKeyboardManager'
end
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      # https://github.com/CocoaPods/CocoaPods/issues/9884
     config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
 end
end

