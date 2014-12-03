class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :player_a
      t.string :player_b
      t.string :result

      t.timestamps
    end
  end
end
