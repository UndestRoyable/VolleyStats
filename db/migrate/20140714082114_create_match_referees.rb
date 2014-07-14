class CreateMatchReferees < ActiveRecord::Migration
  def change
    create_table :match_referees do |t|
      t.references :match, index: true
      t.references :referee, index: true

      t.timestamps
    end
  end
end
