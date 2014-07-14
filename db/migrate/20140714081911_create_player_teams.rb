class CreatePlayerTeams < ActiveRecord::Migration
  def change
    create_table :player_teams do |t|
      t.references :player, index: true
      t.references :team, index: true
      t.datetime :from
      t.datetime :to

      t.timestamps
    end
  end
end
