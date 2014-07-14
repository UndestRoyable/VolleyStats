class CreateReferees < ActiveRecord::Migration
  def change
    create_table :referees do |t|
      t.string :first_name
      t.string :last_name
      t.references :country, index: true

      t.timestamps
    end
  end
end
