class CreateGames < ActiveRecord::Migration[7.2]
  def change
    create_table :games do |t|
      t.datetime :release_date
      t.string :developer
      t.references :system_requirement, null: false, foreign_key: true
      t.references :product, polymorphic: true, index: true

      t.timestamps
    end
  end
end
