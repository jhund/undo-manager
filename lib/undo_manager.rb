# Responsibilities
# * Manage undo stack
# * Manage redo stack
# * clear redo stack when new undo command is added
# Collaborators
# * Command
class UndoManager

  attr_reader :redo_stack, :undo_stack

  # Initializes a new UndoManager.
  # @param undo_stack [Array, optional]
  def initialize(undo_stack = [])
    @undo_stack = undo_stack
    @redo_stack = []
    @total_ops_counter = 0
  end

  # Returns true if there is at least one command to be redone.
  def can_redo?
    @redo_stack.any?
  end

  # Returns true if there is at least one command to be undone.
  def can_undo?
    @undo_stack.any?
  end

  # Pushes a new command onto the undo_stack.
  # @param command [#do, #undo] a command object that responds to #do and #undo
  # @return [Integer] number of total commands
  def record_new_command(command)
    @redo_stack = [] # clear redo stack
    @undo_stack.push(command)
  end

  # Redoes command at top of redo_stack.
  # @return [Command, nil] the redone command or nil if nothing was redone
  def redo_command
    o = @redo_stack.pop
    if o
      o.do # redo the command
      @undo_stack.push(o)
    end
    o
  end

  # Undoes command at top of undo_stack.
  # @return [Command, nil] the undone command or nil if nothing was undone
  def undo_command
    o = @undo_stack.pop
    if o
      o.undo # undo the command
      @redo_stack.push(o)
    end
    o
  end

end
