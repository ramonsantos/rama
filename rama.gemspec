# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require_relative 'lib/rama/version'

Gem::Specification.new do |spec|
  spec.name          = 'rama'
  spec.version       = Rama::VERSION
  spec.authors       = ['ramonsantos']
  spec.email         = ['ramonsantos.pe@gmail.com']

  spec.summary       = 'Ruby project generator.'
  spec.description   = 'Ruby project generator.'
  spec.homepage      = 'https://github.com/ramonsantos/rama'
  spec.required_ruby_version = Gem::Requirement.new('>= 4.0.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/ramonsantos/rama'
  spec.metadata['changelog_uri'] = 'https://github.com/ramonsantos/rama'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore])
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
