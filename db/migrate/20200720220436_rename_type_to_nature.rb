class RenameTypeToNature < ActiveRecord::Migration[6.0]
  def change
    rename_column :items, :type, :nature
  end
end
