class AddPostBodyToJsonEntries < ActiveRecord::Migration[6.0]
  def change
    add_column :json_entries, :post_body, :string
  end
end
