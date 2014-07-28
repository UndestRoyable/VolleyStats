class AddScoutHallToMatch < ActiveRecord::Migration
  def change
  	add_column :matches,:hall_id,:integer
  	add_column :matches,:scout_id,:integer
  end
end
