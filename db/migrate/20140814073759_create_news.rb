class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.references :match, index: true
      t.string :teams

      t.timestamps
    end
  end
end
