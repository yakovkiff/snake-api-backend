class AddHighschoreToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :high_score, :integer
  end
end
