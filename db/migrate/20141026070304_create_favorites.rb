class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.string :title
      t.references :user, index: true
      t.references :player, index: true
      t.references :project, index: true

      t.timestamps
    end
  end
end
