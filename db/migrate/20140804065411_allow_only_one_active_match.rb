class AllowOnlyOneActiveMatch < ActiveRecord::Migration
  def change
    add_column :scouts, :active_match_id, :integer
  end
end
