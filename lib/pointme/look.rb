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
            mime = `file --mime -b #{path}`.chomp!.split(";")[0]
            # Get into files only with that MIME types.
            if (mime == "text/plain" ||
                mime == "text/x-perl" ||
                mime == "text/x-ruby" ||
                mime == "text/x-python" ||
                mime == "text/x-c" ||
                mime == "text/x-c++" ||
                mime == "text/x-shellscript" ||
                mime == "text/x-java" ||
                mime == "text/x-php" ||
                mime == "text/html")
              @files << path
            end
          end
        end
      end
    end

    def self.search_for_tokens
      @files.each do |file|
        @lines[file] = []
        all_lines = `cat -n #{file}`.split("\n")

        all_lines.length.times do |i|
          if /\s*(?<n>[0-9]+)\s+(.*)?(#|\/\/|;|<!--)\s(?<token>TODO|FIXME):\s(?<content>.*)(-->)?/ =~ all_lines[i]
            if @token == token
              j = i + 1
              while /\s*[0-9]+\s+(.*)?(#|\/\/|;)(?<spaces>\s*)(?<moar>[^\s].*)/ =~ all_lines[j]
                break if spaces.length != token.length + 3   # wrong number of spaces
                spaces = n.to_s.length + 7
                content += "\n"
                spaces.times do
                  content += " "
                end
                content += moar
                j += 1
              end
              @lines[file] << [n, token, content]
            end
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
            puts "  at \e[1;32m#{i[0]}\e[0;0m: #{i[2]}"
          end
          puts
        end
        puts "\n  \e[1;33mtotal #{@token}s:\e[0;0m #{@count}\n\n"
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
