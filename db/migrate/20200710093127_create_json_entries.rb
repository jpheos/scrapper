# frozen_string_literal: true

class CreateJsonEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :json_entries do |t|
      t.references :area, null: false, foreign_key: true
      t.json :data
      t.string :name

      t.timestamps
    end
  end
end
