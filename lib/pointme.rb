module Pointme
	ROOT = File.expand_path(File.dirname(__FILE__))
	
	autoload :Look,       "#{ROOT}/pointme/look"
	autoload :Version,    "#{ROOT}/pointme/version"
end
