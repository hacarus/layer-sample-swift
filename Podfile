# platform :ios, '10.0'

target 'LayerSample' do
  use_frameworks!
  pod 'Atlas'
end

# Designation swift version for compiler
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |configuration|
      configuration.build_settings['SWIFT_VERSION'] = "3.0"
    end
  end
end
