class CreateMatchGuests < ActiveRecord::Migration
  def change
    create_table :match_guests do |t|
      t.references :team, index: true
      t.references :match, index: true
      t.integer :result
      t.integer :set1_break1
      t.integer :set1_break2
      t.integer :set1_break3
      t.integer :set2_break1
      t.integer :set2_break2
      t.integer :set2_break3
      t.integer :set3_break1
      t.integer :set3_break2
      t.integer :set3_break3

      t.timestamps
    end
  end
end
