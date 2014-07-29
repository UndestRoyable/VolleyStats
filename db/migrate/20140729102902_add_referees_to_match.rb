class AddRefereesToMatch < ActiveRecord::Migration
  def change
  	add_column :matches,:first_referee_id,:integer
  	add_column :matches,:second_referee_id,:integer
  end
end
