lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'console_snake/version'

Gem::Specification.new do |spec|
  spec.name          = "console-snake-game"
  spec.version       = ConsoleSnake::VERSION
  spec.authors       = ["pekepek"]
  spec.email         = ["ishihata@33i.co.jp"]

  spec.summary       = %q{You can play the snake game in terminal}
  spec.description   = %q{You can play the snake game in terminal}
  spec.homepage      = "https://github.com/pekepek/console-snake-game"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.executables   = spec.files.grep(%r{^bin/}) {|f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_dependency "tty"
end
