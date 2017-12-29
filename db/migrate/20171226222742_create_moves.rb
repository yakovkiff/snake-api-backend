class CreateMoves < ActiveRecord::Migration[5.1]
  def change
    create_table :moves do |t|
      t.string :bearing
      t.integer :x
      t.integer :y
      t.belongs_to :snake_head, foreign_key: true

      t.timestamps
    end
  end
end
