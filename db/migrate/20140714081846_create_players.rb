class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.references :team, index: true
      t.string :first_name
      t.string :last_name
      t.integer :number
      t.references :position, index: true
      t.references :country, index: true

      t.timestamps
    end
  end
end
