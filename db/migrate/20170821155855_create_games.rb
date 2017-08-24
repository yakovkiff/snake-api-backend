class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.integer :frontend_id
      t.belongs_to :user, foreign_key: true
      t.timestamps
    end
  end
end
