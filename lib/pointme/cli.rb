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

    # run! the Cli!
    def run!

      # Nice, cool 'n' AWESOME --options parsing with Trollop[http://trollop.rubyforge.org/]!
      #
      # @return [Hash] array full of options
      $opts = Trollop::options do
        version "pointme version #{Version::STRING}"
        banner <<-EOB
usage: pointme <token> [options]

tokens are:
  todos            look for TODO lines
  fixmes           look for FIXME lines

options are:
EOB
        # TODO: Looking in directories with no recursion.
        # opt :no_recurse, "don't look in directories recursively"
        opt :in, "specify where to look for", :default => Dir.pwd
        opt :version, "show version and exit"
        opt :help, "show help and exit"
      end

      # Let's see what to look for
      token = ARGV.shift.downcase
      unless token == "todos" || token == "fixmes"
        raise Look::UnknownToken, "Unknown token: '#{token}'"
      end
      # Let's see where to look for
      where = $opts[:in] || Dir.pwd

      begin
        Look.for_the token, where
        exit 0
      rescue Interrupt
        puts "\n\n!# interrupted"
        exit 1
      rescue Look::UnknownToken => e
        puts e.message
        exit 2
      end
    end
  end
end
