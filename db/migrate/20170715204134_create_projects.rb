class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.integer :category
      t.attachment :image

      t.timestamps null: false
    end
  end
end
