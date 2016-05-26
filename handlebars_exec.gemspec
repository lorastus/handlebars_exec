Gem::Specification.new do |s|
  s.name        = "handlebars_exec"
  s.version     = '0.1.0'
  s.authors     = ["Anthony Fojas"]
  s.email       = "anthony.fojas@vibes.com"
  s.homepage    = "TODO HOMEPAGE"
  s.summary     = "TODO SUMMARY"
  s.description = "TODO DESCRIPTION"
  s.required_rubygems_version = ">= 1.3.6"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.add_development_dependency "rake"
  s.add_development_dependency "minitest"
  s.add_development_dependency "appraisal"
  s.add_development_dependency "pry"

  s.add_runtime_dependency 'execjs', '>= 2.7.0'
  s.add_runtime_dependency 'handlebars-source'
  s.license = 'MIT'
end
