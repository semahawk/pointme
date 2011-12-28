Pointme
=======

<table>
	<tr>
		<td><b>Homepage</b></td>
		<td><a href="http://semahawk.github.com/pointme">http://semahawk.github.com/pointme</a></td>
	</tr>
	<tr>
		<td><b>Author</b></td>
		<td>Szymon Urbaś (szymon.urbas(at)yahoo.com)</td>
	</tr>
	<tr>
		<td><b>Copyright</b></td>
		<td>2011</td>
	</tr>
	<tr>
		<td><b>License</b></td>
		<td>MIT</td>
	</tr>
	<tr>
		<td> </td>		
		<td> </td>		
	</tr>
	<tr>
		<td><b>Latest version</b></td>
		<td>0.1.0</td>
	</tr>
	<tr>
		<td><b>Release date</b></td>
		<td>September 11th, 2011</td>
	</tr>
	<tr>
		<td><b>Stage</b></td>
		<td><i>Development</i></td>
	</tr>
</table>

## A bit about

A lot of developers leaves in their code lines like this (see line 2) <i>(found this piece of code in ruby's library, in rake.rb file, lines 1305 - 1316 [ruby-1.9.2p136 revision 30365])</i>:

    def include(*filenames)
      # TODO: check for pending
      filenames.each do |fn|
        if fn.respond_to? :to_ary
          include(*fn.to_ary)
        else
          @pending_add << fn
        end
      end
      @pending = true
      self
    end

Pointme's role is to find all of these TODO, FIXME and so-on lines and hold'em all in one place. 

## Features

So far, Pointme can only pointyou TODOs and FIXMEs but in undeterminated future it would be able to look for both of them.

Pointme can handle several language comments like:
+ # TODO: make it do it
+ // FIXME: make us fix it
+ ; TODO: Mwahahahaha!
+ <!-- TODO: Ghehehe -->

## Dependencies

+ ruby (working just great on 1.9.2, haven't tried it on other versions yet)
+ rubygems (the newest the better [for sure works under 1.8.5])

## Beware, beware! A bug!

If you encountered a bug, please let me know by adding a new [issue](http://github.com/semahawk/pointme/issues). Thank you in advance :)

## Contributing to Pointme

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2011 Szymon Urbaś. See [LICENSE](http://github.com/semahawk/pointme/blob/master/LICENSE) file for further details.
