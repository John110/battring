class CreateChatlogs < ActiveRecord::Migration
  def change
    create_table :chatlogs do |t|
      t.string :username
      t.string :message
      t.string :url

      t.timestamps
    end
  end
end
