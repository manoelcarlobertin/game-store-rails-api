class AddModeToGames < ActiveRecord::Migration[7.2]
  def change
    add_column :games, :mode, :integer
  end
end
