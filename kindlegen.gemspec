# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "kindlegen/version"

Gem::Specification.new do |s|
  s.name        = "kindlegen"
  s.version     = Kindlegen::VERSION
  s.platform    = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.5.0'

  s.authors     = ["TADA Tadashi"]
  s.email       = ["t@tdtds.jp"]
  s.homepage    = ""
  s.license     = "GPLv3"
  s.summary     = %q{Installing kindlegen command.}
  s.description = %q{Installing kindlegen command, downloading tar.gz file from amazon.com, and extracting it and copy kindlegen command to bin.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.bindir        = 'exe'
  s.executables   = s.files.grep(%r{^exe/}){|f| File.basename(f)}
  s.require_paths = ["lib"]
  s.extensions    = ['ext/Rakefile']

  s.add_dependency 'rubyzip'
  s.add_dependency "rake"

  # specify any dependencies here; for example:
  s.add_development_dependency "pry"
  s.add_development_dependency "test-unit"
end
