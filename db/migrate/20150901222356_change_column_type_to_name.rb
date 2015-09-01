class ChangeColumnTypeToName < ActiveRecord::Migration
  def change
    remove_column(:resources, :type, :string)
    add_column(:resources, :name, :string)
  end
end
