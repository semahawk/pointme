require "find"

module Pointme
  module Look
    
    # Kinda self explanatory
    class UnknownToken < RuntimeError; end
    
    # @files holds all the specified files that Look should search in.
    # @lines keeps all the found TODO, FIXME and so-on lines.
    attr_accessor :files, :lines
    
    def self.get_file_list
      @where.split(":").each do |e|
        if e == '.' then e = Dir.pwd end
        @dirs << e unless @dirs.include? e
        Find.find(e) do |path|
          if File.directory? path
            if File.basename(path)[0] == ?.
              Find.prune # don't look any further into this directory.
            else
              next
            end
          else
            ext = File.extname(path)[1..-1]
            # TODO: Make it look in files with proper MIME type not extension.
            # Don't look into files with that extensions
            unless (ext == "class" ||
                    ext == "jar"
                    ext == "rar"
                    ext == "bz"
                    ext == "bz2"
                    ext == "gz"
                    ext == "tgz"
                    ext == "zip")
              @files << path
            end
          end
        end
      end
    end
    
    def self.search_for_tokens
      @files.each do |file|
        @lines[file] = []
        `cat -n #{file}`.split("\n").each do |line|
          if /\s*(?<n>[0-9]+)\s+(.*)?(#|\/\/|;|<!--)\s(?<token>TODO|FIXME):?\s(?<content>.*)(-->)?/ =~ line
            @lines[file] << [n, token, content] if @token == token
          end
        end
        
        if @lines[file].empty?
          @lines.delete file
        end
      end
    end
     
    def self.print_output
      if @lines.empty?
        puts "[pointme] there are no #{@token}s in a specified path/s"
      else
        @lines.each do |e|
          name = nil
          if @dirs.size == 1
            name = e[0].sub @where, ""
          else
            name = e[0]
          end
          puts "\e[1;34m" + name + ":\e[0;0m"
          e[1].each do |i|
            @count += 1
            puts "  at \e[1;32m#{i[0]}\e[0;0m: #{i[1]} -> #{i[2]}"
          end
          puts
        end
        puts "\n  \e[1;33mtotal:\e[0;0m #{@count}\n\n"
      end
    end
    
    def self.for_the token, where
      @files   = []
      @lines   = {}
      @token   = token.upcase[0..-2]
      @where   = where
      @count   = 0
      @dirs    = []
      
      get_file_list and search_for_tokens and print_output
    end
  end
end
