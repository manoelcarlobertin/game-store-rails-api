class AddModeToGames < ActiveRecord::Migration[8.0]
  def change
    add_column :games, :mode, :integer
  end
end
