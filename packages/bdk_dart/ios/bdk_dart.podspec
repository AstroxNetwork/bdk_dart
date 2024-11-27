#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint bdk_dart.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name          = 'bdk_dart'
  s.version       = '1.0.0'
  s.license       = { :file => '../LICENSE' }
  s.homepage      = 'https://github.com/AstroxNetwork/bdk_dart'
  s.authors       = { 'AstroX Dev' => 'dev@astrox.network' }
  s.summary       = 'iOS/macOS Flutter bindings for bdk_dart'

  # This will ensure the source files in Classes/ are included in the native
  # builds of apps using this FFI plugin. Podspec does not support relative
  # paths, so Classes contains a forwarder C file that relatively imports
  # `../src/*` so that the C sources can be shared among all target platforms.
  s.source              = { :path => '.' }
  s.source_files        = 'Classes/**/*'

  s.dependency 'Flutter'
  s.platform = :ios, '11.0'
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  s.ios.deployment_target = '11.0'
  s.osx.deployment_target = '10.11'

  s.script_phase = {
    :name => 'Build Rust library',
    :execution_position => :before_compile,
    :input_files => ['${BUILT_PRODUCTS_DIR}/cargokit_phony'],
    # Let XCode know that the static library referenced in -force_load below is
    # created by this build step.
    :output_files => ["${BUILT_PRODUCTS_DIR}/libbdk_dart.a"],
    :shell_path => '/bin/bash',
    :script => <<-SCRIPT
    [ -f "$HOME/.profile" ] && source "$HOME/.profile"
    [ -f "$HOME/.bash_profile" ] && source "$HOME/.bash_profile"
    "$PODS_TARGET_SRCROOT/../cargokit/build_pod.sh" ../native/bdk_dart bdk_dart
    SCRIPT
  }
  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    # Flutter.framework does not contain a i386 slice.
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
    'OTHER_LDFLAGS' => '-force_load ${BUILT_PRODUCTS_DIR}/libbdk_dart.a',
  }
end
