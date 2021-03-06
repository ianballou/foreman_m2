require File.expand_path('lib/foreman_m2/version', __dir__)

Gem::Specification.new do |s|
  s.name        = 'foreman_m2'
  s.version     = ForemanM2::VERSION
  s.license     = 'GPL-3.0'
  s.authors     = ['Ian Ballou']
  s.email       = ['iballou@redhat.com']
  s.homepage    = 'https://github.com/ianballou/foreman_m2'
  s.summary     = %q{M2 bare metal provisioning plugin for Foreman}
  # also update locale/gemspec.rb
  s.description = 'M2 bare metal provisioning plugin for Foreman'

  s.files = Dir['{app,config,db,lib,locale}/**/*'] +
    ['LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_development_dependency 'rdoc'
  s.add_development_dependency 'rubocop'
  s.add_dependency 'deface'
end
