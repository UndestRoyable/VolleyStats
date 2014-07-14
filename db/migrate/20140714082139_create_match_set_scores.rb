class CreateMatchSetScores < ActiveRecord::Migration
  def change
    create_table :match_set_scores do |t|
      t.references :match, index: true
      t.integer :set_number
      t.integer :host_score
      t.integer :guest_score

      t.timestamps
    end
  end
end
