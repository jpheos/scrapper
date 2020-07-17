class AddVerbToJsonEntries < ActiveRecord::Migration[6.0]
  def change
    add_column :json_entries, :verb, :boolean, default: false
  end
end
