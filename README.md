# undo-manager

undo-manager makes it easy to add undo/redo functionality to a Ruby (on Rails) app. It uses the command pattern to do so. undo-manager provides the handling of undo and redo. It’s up to you to implement the `#do` and `#undo` methods for each of your commands.


## Installation

`gem install undo-manager`

or with bundler in your Gemfile:

`gem 'undo-manager'`


## Dependencies

* Ruby >= 1.9.3


## Resources

* [API documentation](http://www.rubydoc.info/gems/undo-manager/)
* [Changelog](https://github.com/jhund/undo-manager/blob/master/CHANGELOG.md)
* [Source code (github)](https://github.com/jhund/undo-manager)
* [Issues](https://github.com/jhund/undo-manager/issues)
* [Rubygems.org](http://rubygems.org/gems/undo-manager)

[![Build Status](https://travis-ci.org/jhund/undo-manager.svg?branch=master)](https://travis-ci.org/jhund/undo-manager)

[![Code Climate](https://codeclimate.com/github/jhund/undo-manager.png)](https://codeclimate.com/github/jhund/undo-manager)

## License

[MIT licensed](https://github.com/jhund/undo-manager/blob/master/MIT-LICENSE).

## Copyright

Copyright (c) 2015 Jo Hund. See [(MIT) LICENSE](https://github.com/jhund/undo-manager/blob/master/MIT-LICENSE) for details.
