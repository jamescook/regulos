# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
 
require 'regulos/version'
 
Gem::Specification.new do |s|
  s.name        = "regulos"
  s.version     = Regulos::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["James Cook"]
  s.email       = ["james@isotope11.com"]
  s.homepage    = "http://github.com/jamecook/regulos"
  s.summary     = "'Rift - Planes of Telera' combat log parser"
  s.description = "Regulos parses combat logs for reporting & statistics."
 
  s.required_rubygems_version = ">= 1.3.6"

  s.add_development_dependency "rspec"
 
  s.files        = Dir.glob("{lib}/**/*") + %w(README.md CHANGELOG.md)
  s.require_path = 'lib'
 end
