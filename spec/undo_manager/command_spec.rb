require_relative '../spec_helper'

class UndoManager
  describe Command do

    it 'responds to #do' do
      Command.new.must_respond_to(:do)
    end

    it 'responds to #undo' do
      Command.new.must_respond_to(:undo)
    end

  end
end
