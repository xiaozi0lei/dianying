class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :name
      t.text :description
      t.string :picture
      t.string :path

      t.timestamps
    end
  end
end
