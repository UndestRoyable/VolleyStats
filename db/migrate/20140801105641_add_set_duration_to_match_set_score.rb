class AddSetDurationToMatchSetScore < ActiveRecord::Migration
  def change
  	add_column :match_set_scores, :duration,:integer
  end
end
