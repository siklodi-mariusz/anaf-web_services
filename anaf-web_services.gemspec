# frozen_string_literal: true

require_relative 'lib/anaf/web_services/version'

Gem::Specification.new do |spec|
  spec.name = 'anaf-web_services'
  spec.version = ANAF::WebServices::VERSION
  spec.authors = ['Mariusz Siklodi']
  spec.summary = 'Ruby Client library for ANAF API'
  spec.description = ''
  spec.homepage = 'https://github.com/siklodi-mariusz/anaf-web_services'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.7.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/siklodi-mariusz/anaf-web_services'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  spec.add_dependency 'faraday', '>= 1.0.0', '< 3.0'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
