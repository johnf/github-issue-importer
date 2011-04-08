# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "github-issue-importer/version"

Gem::Specification.new do |s|
  s.name        = "github-issue-importer"
  s.version     = Github::Issue::Importer::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['John Ferlito']
  s.email       = ['johnf@inodes.org']
  s.homepage    = ""
  s.summary     = %q{Launchpad to Github bug importer}
  s.description = %q{Migrate bugs from a Launchpas project into Github Issues}

  s.rubyforge_project = "github-issue-importer"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('octopi')
  s.add_dependency('trollop')

  s.add_development_dependency('awesome_print')
end
