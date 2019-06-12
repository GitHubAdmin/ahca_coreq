
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ahca_coreq/version"

Gem::Specification.new do |spec|
  spec.name          = "AHCACoreQ"
  spec.version       = AhcaCoreq::VERSION
  spec.authors       = ["Phil Doise"]
  spec.email         = ["phil.doise@healthstream.com"]

  spec.summary       = %q{Gem for communicating with AHCA API}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/github_admin/ahca_coreq.git"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rest-client", "~> 2.0"
  spec.add_development_dependency "pry", "~> 0.11"
  spec.add_development_dependency "vcr", "~> 4.0"
  spec.add_development_dependency "webmock", "~> 3.2"
  spec.add_development_dependency "addressable", "~> 2.5"

  spec.add_runtime_dependency 'activesupport', '>= 3.2'
end
