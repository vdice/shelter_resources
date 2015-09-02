class RenameQuantitiesToItems < ActiveRecord::Migration
  def change
    rename_table(:quantities, :items)
    add_column(:items, :name, :string)
  end
end
