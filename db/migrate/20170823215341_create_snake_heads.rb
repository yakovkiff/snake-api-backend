class CreateSnakeHeads < ActiveRecord::Migration[5.1]
  def change
    create_table :snake_heads do |t|
      t.string :bearing
      t.integer :x
      t.integer :y
      t.belongs_to :game, foreign_key: true
    end
  end
end
