class CreatePictures < ActiveRecord::Migration[7.0]
  def change
    create_table :pictures do |t|
      t.text :url
      t.text :context
      t.references :imageable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
