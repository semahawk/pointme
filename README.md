Pointme
=======

Pointme is a simple command line utility, that searches for TODO and FIXME lines, and stores them all on a screen.

## Installation

Pointme is a gem, so that would do the job:

    [sudo] gem install pointme

## Usage

Pointme takes as first argument a token name: could be "todos" or "fixmes".

    pointme todos

This will search in your current working directory, but you also can specify where to look, by passing these places (can be both directories and files) in a `--in` option.

    pointme todos --in /home/me/projects/current

You can pass several dirs and/or files by separating them with `:` sign.

    pointme fixmes --in /home/me/projects/current:/home/me/projects/old_one:/home/me/projects/another/README.md

If you want to pass current directory, just give him a `.` (dot).

    pointme todos --in /home/me/projects/current:.:/home/me/code/somewhere

## Features

So far, Pointme can only pointyou TODOs and FIXMEs but in undeterminated future it would be able to look for both of them or even for maybe NOTEs or HACKs. Yup, definitely a TODO.

Pointme can handle several language comments like:
+ # TODO: content
+ // FIXME: content
+ ; TODO: content
+ <!-- TODO: content -->

## Supported MIME types

+ text/plain
+ text/x-ruby
+ text/x-python
+ text/x-c
+ text/x-c++
+ text/x-shellscript
+ text/x-java
+ text/x-php
+ text/html

## Dependencies

+ ruby (working just great on 1.9.2, haven't tried it on other versions yet)
+ rubygems (the newest the better [for sure works under 1.8.5])
+ a UNIX tools called `cat` and `file` (but you have them, right?)

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

## License

Pointme is licensed under the MIT License. See [LICENSE](http://github.com/semahawk/pointme/blob/master/LICENSE) file for further details.
