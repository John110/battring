class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.references :matching, index: true
      t.string :player_a
      t.string :player_b
      t.string :result
      t.string :next
      t.string :book
      t.integer :first_battle_time

      t.timestamps
    end
  end
end
