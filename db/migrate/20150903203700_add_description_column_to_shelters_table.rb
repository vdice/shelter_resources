class AddDescriptionColumnToSheltersTable < ActiveRecord::Migration
  def change
    add_column(:shelters, :description, :string)
  end
end
