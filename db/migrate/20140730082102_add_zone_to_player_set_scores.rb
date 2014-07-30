class AddZoneToPlayerSetScores < ActiveRecord::Migration
  def change
  	add_column :player_set_scores, :zone,:integer
  end
end
