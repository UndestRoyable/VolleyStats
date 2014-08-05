class AddSet4Break1ToMatchSetScore < ActiveRecord::Migration
  def change
  add_column :match_hosts, :set4_break1, :integer
  add_column :match_hosts, :set4_break2, :integer
  add_column :match_hosts, :set4_break3, :integer

  add_column :match_hosts, :set5_break1, :integer
  add_column :match_hosts, :set5_break2, :integer
  add_column :match_hosts, :set5_break3, :integer

  add_column :match_guests, :set4_break1, :integer
  add_column :match_guests, :set4_break2, :integer
  add_column :match_guests, :set4_break3, :integer

  add_column :match_guests, :set5_break1, :integer
  add_column :match_guests, :set5_break2, :integer
  add_column :match_guests, :set5_break3, :integer


  end
end
