class CreateHalls < ActiveRecord::Migration
  def change
    create_table :halls do |t|
      t.string :name
      t.references :city, index: true

      t.timestamps
    end
  end
end
