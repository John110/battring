class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :contributor
      t.string :time
      t.references :project, index: true

      t.timestamps
    end
  end
end
