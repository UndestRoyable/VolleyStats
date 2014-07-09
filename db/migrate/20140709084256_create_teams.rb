class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :number_players
      t.references :coach, index: true

      t.timestamps
    end
  end
end
