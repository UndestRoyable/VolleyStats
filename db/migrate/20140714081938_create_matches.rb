class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.datetime :date
      t.references :match_host, index: true
      t.references :match_guest, index: true
      t.datetime :duration

      t.timestamps
    end
  end
end
