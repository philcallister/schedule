# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")

begin
  require 'motion/project/template/ios'
  require 'bundler'
  require 'motion-testflight'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Schedule'
  app.identifier = 'com.philcallister.Schedule'
  app.info_plist['UIMainStoryboardFile'] = 'MainStoryboard'
  app.interface_orientations = [:portrait]
  app.prerendered_icon = false
  #app.info_plist['UIViewControllerBasedStatusBarAppearance'] = false

  app.vendor_project('vendor/GoogleMaps.framework',
    :static,
    :products    => %w{GoogleMaps},
    :headers_dir => 'Headers')
  app.resources_dirs << 'vendor/GoogleMaps.framework/Resources'
  app.frameworks += %w{AVFoundation CoreData CoreLocation CoreText GLKit ImageIO OpenGLES QuartzCore SystemConfiguration, MapKit}
  app.libs       += %w{/usr/lib/libicucore.dylib /usr/lib/libc++.dylib /usr/lib/libz.dylib}


  #app.testflight.sdk = 'vendor/TestFlightSDK3.0.2'
  #app.testflight.api_token = '9056f33ee65d4b8d11ee48af3f46bd5a_MTE1NDYxMzIwMTMtMDctMDggMDk6NDk6MzcuNTM1MDQ0'
  #app.testflight.team_token = '6534a7e693c9b00b660e39028c0c070b_MjQ1NzI2MjAxMy0wNy0wOCAwOTo1NDoxNi44Njg1NDU'

  app.pods do
    pod 'ECSlidingViewController', podspec: 'https://raw.githubusercontent.com/ECSlidingViewController/ECSlidingViewController/1.3.2/ECSlidingViewController.podspec'
    #pod 'ECSlidingViewController', podspec: 'https://raw.githubusercontent.com/CocoaPods/Specs/master/Specs/ECSlidingViewController/1.3.2/ECSlidingViewController.podspec.json'
    #pod 'DIDatepicker', podspec: 'https://raw.githubusercontent.com/CocoaPods/Specs/master/Specs/DIDatepicker/0.1/DIDatepicker.podspec.json'
  end

  app.development do
    # This entitlement is required during development but must not be used for release.
    app.codesign_certificate = "iPhone Developer: Phil Callister (UHKN5WEMMP)"
    app.provisioning_profile = "/Users/philcallister/Library/MobileDevice/Provisioning\ Profiles/1AB6DBA0-7A3B-41A1-8E0D-BC008377C58E.mobileprovision"
    app.entitlements['get-task-allow'] = true
  end

end
