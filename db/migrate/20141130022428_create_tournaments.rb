class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.references :matching
      t.datetime :start
      t.string :participants
      t.string :result
      t.string :cards

      t.timestamps
    end
  end
end
