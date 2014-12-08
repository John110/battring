class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.references :matching, index: true
      t.string :participants
      t.datetime :start
      t.string :result
      t.string :cards
      t.boolean :is_second_battle
      t.references :card, index: true

      t.timestamps
    end
  end
end
