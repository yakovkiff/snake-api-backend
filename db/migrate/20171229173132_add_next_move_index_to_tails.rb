class AddNextMoveIndexToTails < ActiveRecord::Migration[5.1]
  def change
    add_column :tails, :next_move_index, :integer
  end
end
