#
# Be sure to run `pod lib lint EmbeddedProvision.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name             = 'EmbeddedProvision'
  s.version          = package['version']
  s.summary          = 'Embedded Provision'
  s.description      = 'Handy helpers for reading values from an applications embedded provision profiles.'

  s.homepage         = 'https://magicbell.com'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'MagicBell' => 'hello@magicbell.com' }
  s.source           = { :git => 'https://github.com/magicbell/embedded-provision.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/magicbell_io'

  s.osx.deployment_target = '10.15'
  s.ios.deployment_target = '12.0'

  s.swift_versions = ['5.3', '5.4', '5.5']

  s.source_files = 'Source/**/*.swift'
end
