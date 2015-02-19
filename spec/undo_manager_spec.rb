require_relative 'spec_helper'

describe UndoManager do

  class TestCommand < UndoManager::Command

    attr_reader :do_count, :undo_count

    def initialize
      @do_count = 0
      @undo_count = 0
    end

    def do
      @do_count += 1
    end

    def undo
      @undo_count += 1
    end

  end

  describe 'A new UndoManager' do

    let(:undo_manager){ UndoManager.new([]) }

    it 'has an empty undo_stack' do
      undo_manager.undo_stack.must_be_empty
    end

    it 'cannot undo' do
      undo_manager.can_undo?.must_equal false
    end

    it 'has an empty redo_stack' do
      undo_manager.redo_stack.must_be_empty
    end

    it 'cannot redo' do
      undo_manager.can_redo?.must_equal false
    end

    it 'uses the undo_stack passed as argument' do
      us = [1,2,3]
      UndoManager.new(us).undo_stack.must_equal [1,2,3]
    end

  end

  describe 'UndoManager with commands in the undo_stack' do

    let(:undo_manager){ UndoManager.new([1,2,3]) }

    it 'has commands in the undo_stack' do
      undo_manager.undo_stack.wont_be_empty
    end

    it 'has an empty redo_stack' do
      undo_manager.redo_stack.must_be_empty
    end

    it 'can_undo' do
      undo_manager.can_undo?.must_equal true
    end

  end

  describe '#can_redo?' do

    it 'returns false for empty redo_stack' do
      UndoManager.new.can_redo?.must_equal false
    end

    it 'returns true for non-empty redo_stack' do
      undo_manager = UndoManager.new([TestCommand.new])
      undo_manager.undo_command
      undo_manager.can_redo?.must_equal true
    end

  end

  describe '#can_undo?' do

    it 'returns false for empty undo_stack' do
      UndoManager.new.can_undo?.must_equal false
    end

    it 'returns true for non-empty undo_stack' do
      undo_manager = UndoManager.new([TestCommand.new])
      undo_manager.can_undo?.must_equal true
    end

  end


  describe '#record_new_command' do

    let(:undo_manager){ UndoManager.new([]) }

    it 'starts with an empty undo_stack' do
      undo_manager.undo_stack.must_be_empty
    end

    it 'records a new command' do
      undo_manager.must_respond_to(:record_new_command)
    end

    it 'adds new command to undo_stack' do
      undo_manager.record_new_command(1)
      undo_manager.undo_stack.must_equal [1]
    end

    it 'clears the redo_stack' do
      o = TestCommand.new
      undo_manager.record_new_command(o)
      undo_manager.undo_command
      undo_manager.redo_stack.must_equal [o]
      undo_manager.record_new_command(1)
      undo_manager.redo_stack.must_be_empty
    end

  end

  describe 'redo_command' do

    let(:command1){ TestCommand.new }
    let(:command2){ TestCommand.new }
    let(:undo_manager){
      um = UndoManager.new([command1, command2])
      um.undo_command
      um
    }

    it 'redoes and returns the most recently undone command' do
      undo_manager.redo_command.must_equal command2
    end

    it 'calls #do on the redone command' do
      undo_manager.redo_command
      command2.do_count.must_equal 1
    end

    it 'pushes the redone command onto the undo_stack' do
      undo_manager.redo_command
      undo_manager.undo_stack.last.must_equal command2
    end

  end

  describe 'undo_command' do

    let(:command1){ TestCommand.new }
    let(:command2){ TestCommand.new }
    let(:undo_manager){ UndoManager.new([command1, command2]) }

    it 'undoes and returns the most recent command' do
      undo_manager.undo_command.must_equal command2
    end

    it 'calls #undo on the undone command' do
      undo_manager.undo_command
      command2.undo_count.must_equal 1
    end

    it 'pushes the undone command onto the undo_stack' do
      undo_manager.undo_command
      undo_manager.redo_stack.last.must_equal command2
    end

  end

end
