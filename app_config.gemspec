# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'app_config'
  s.version     = '1.0.0'
  s.authors     = ['Medivo Developers']
  s.email       = ['developers@medivo.com']
  s.homepage    = ''
  s.summary     = %q{Flexible application wide configuration plugin}
  s.description = %q{Flexible application wide configuration plugin}
  s.license     = 'MIT'

  s.rubyforge_project = 'app_config'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency 'activesupport'
  s.add_development_dependency 'rake'
end
