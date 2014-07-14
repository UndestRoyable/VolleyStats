class CreateCoaches < ActiveRecord::Migration
  def change
    create_table :coaches do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.references :country, index: true

      t.timestamps
    end
  end
end
