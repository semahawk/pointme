# encoding: utf-8

require "lib/pointme/version"

Gem::Specification.new do |s|
  s.name        = "pointme"
  s.version     = Pointme::Version::STRING
  s.authors     = ["Szymon Urbaś"]
  s.email       = ["szymon.urbas@yahoo.com"]
  s.homepage    = "http://github.com/semahawk/pointme"
  s.summary     = %q{It'll point you all the hidden treasures like TODOs and FIXMEs!}
  s.description = %q{It'll point you all the hidden treasures like TODOs and FIXMEs!}
  s.date        = Time.now.strftime "%Y-%m-%d"
  
  s.files         = `git ls-files`.split "\n"
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split "\n"
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ["lib"]
end
