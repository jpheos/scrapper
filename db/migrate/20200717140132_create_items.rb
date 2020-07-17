class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :json_entry, null: false, foreign_key: true
      t.string :title
      t.string :url
      t.string :image
      t.string :price
      t.string :area
      t.string :type
      t.string :zipcode
      t.string :city

      t.timestamps
    end
  end
end
