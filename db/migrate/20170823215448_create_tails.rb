class CreateTails < ActiveRecord::Migration[5.1]
  def change
    create_table :tails do |t|
      t.string :bearing
      t.integer :x
      t.integer :y
      t.belongs_to :snake_head, foreign_key: true
    end
  end
end
