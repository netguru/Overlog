#
# Overlog.podspec
# Copyright © 2018 Netguru S.A. All rights reserved.
#

Pod::Spec.new do |spec|

  # Metadata

  spec.name = 'Overlog'
  spec.version = '1.0.0'
  spec.summary = 'Overlay for iOS apps for easier testing and debugging.'
  spec.homepage = 'https://netguru.co/overlog'

  spec.author = 'Netguru'
  spec.license = { type: 'MIT', file: 'LICENSE.md' }

  # Sources

  spec.source = { git: 'https://github.com/netguru/Overlog.git', tag: spec.version.to_s }

  spec.source_files = 'Overlog/Sources/**/*.swift'
  spec.resources = 'Overlog/Resources/**/*.xcassets'

  # Settings

  spec.swift_version = '4.1'

  spec.requires_arc = true
  spec.ios.deployment_target = '8.0'

  # Dependencies

  spec.dependency 'ResponseDetective', '~> 1.2'

end
