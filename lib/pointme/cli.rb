require "trollop"

module Pointme
	
	# Command Line Interface class
	# 
	# === Usage
	# 
	#     module Pointme
	#        Cli.new.run!
	#     end
	# 
	# or
	# 
	#     Pointme::Cli.new.run!
	# 
	# === Exit statuses
	# 
	# - *0* Everything went just fine :)
	# - *1* User said ^C :]
	# - *2* User wanted to look for UnknownToken
	# 
	class Cli
		
		# Kinda self explanatory
		class UnknownToken < RuntimeError; end
		
		# It holds what user wants to see
		attr_accessor :token
		
		# run! the Cli!
		def run!
			
			# Nice, cool 'n' AWESOME --options parsing with Trollop[http://trollop.rubyforge.org/]!
			# 
			# @return [Hash] array full of options
			$opts = Trollop::options do
				version "pointme version #{Version::STRING}"
				banner <<-EOB
usage: pointme [options] todos|fixmes|hacks

options are:
EOB
				opt :version, "show version and exit"
				opt :help, "show help and exit"
			end
			
			# Let's see what to look for
			@token = ARGV.shift.downcase.to_sym
			
			begin
				look_for @token
				exit 0
			rescue Interrupt
				puts "\n\n!# interrupted"
				exit 1
			rescue UnknownToken => e
				puts e.message
				exit 2
			end
		end
		
		def look_for token
			# TODO
		end
	end
end
