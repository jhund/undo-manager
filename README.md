# undo-manager

undo-manager makes it easy to add undo/redo functionality to a Ruby (on Rails) app. It uses the command pattern to do so. undo-manager provides the handling of undo and redo. It’s up to you to implement the `#do` and `#undo` methods for each of your commands.


## Installation

`gem install undo-manager`

or with bundler in your Gemfile:

`gem 'undo-manager'`


## Usage

Let's assume you have an ActiveRecord based `Workflow` class that manages commands. It is used to store commands that are executed in a given context. Using `UndoManager` and the command pattern allows you to record which commands were executed, and you can undo and redo them. Obviously this is only suitable for commands that are reversible. 

The `Workflow` class has a text column named `commands_stack` in which you store commands that are executed as part of the workflow. It also has an `#undo_manager` getter. This method initializes a new UndoManager on first call and memoizes it. We pass the `commands_stack` to the initializer. UndoManager will use it as an `undo_stack`. It will be persisted to the database every time you call `save` on a `Workflow` object.

~~~ ruby
class Workflow < ActiveRecord::Base
  serialize :commands_stack, Array
  
  delegate :record_new_command, :redo_command, :undo_command, to: :undo_manager
  
  def undo_manager
    @undo_manager ||= UndoManager.new(commands_stack)
  end
end
~~~

Let's implement your command objects. In order to work with `UndoManager`, they need to respond to two methods: `#do` and `#undo`. These methods are called with no arguments. You need to provide all data for the command on initialization. In our example we pass in record ids on which we want to operate. Your command objects will likely be more complex.

~~~ ruby
class MyCommand < UndoManager::Command
  def initialize(record_id)
    @record_id = record_id
  end
  
  def do
    # do something with record_id
  end
  
  def undo
    # undo whatever we do to record_id
  end
end
~~~

And this is how it's all tied together:

~~~ ruby
class MyCommandsController < ApplicationController
  
  def do
    @workflow = Workflow.find(id)
    command = MyCommand.new(params[:record_id])
    command.do
    @workflow.record_new_command(command)
    @workflow.save
  end
  
  def undo
    @workflow = Workflow.find(id)
    @workflow.undo_command
    @workflow.save
  end
  
  def redo
    @workflow = Workflow.find(id)
    @workflow.redo_command
    @workflow.save
  end
  
end
~~~

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
