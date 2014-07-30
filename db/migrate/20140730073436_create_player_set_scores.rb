class CreatePlayerSetScores < ActiveRecord::Migration
  def change
    create_table :player_set_scores do |t|
      t.references :match_set_score, index: true
      t.references :player, index: true
      t.integer :points_total
      t.integer :block_points
      t.integer :won_lost
      t.integer :serve_total
      t.integer :serve_errors
      t.integer :serve_aces
      t.integer :reception_total
      t.integer :reception_errors
      t.integer :reception_efficiency
      t.integer :attack_total
      t.integer :attack_errors
      t.integer :attack_blocks
      t.integer :attack_points
      t.integer :attack_efficiency
      t.integer :break_points

      t.timestamps
    end
  end
end
