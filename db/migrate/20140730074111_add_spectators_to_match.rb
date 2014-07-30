class AddSpectatorsToMatch < ActiveRecord::Migration
  def change
  	add_column :matches, :spectators,:integer
  end
end
