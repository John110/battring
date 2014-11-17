class CreateMatchings < ActiveRecord::Migration
  def change
    create_table :matchings do |t|
      t.string :name
      t.string :owner
      t.string :title
      t.string :reguration
      t.datetime :limit
      t.datetime :start
      t.text :memo
      t.references :user, index: true
      t.references :project, index: true

      t.timestamps
    end
  end
end
