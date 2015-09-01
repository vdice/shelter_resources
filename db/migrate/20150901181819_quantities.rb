class Quantities < ActiveRecord::Migration
  def change
    create_table(:quantities) do |t|
      t.column(:resource_id, :integer)
      t.column(:shelter_id, :integer)
      t.column(:quantity, :integer)

      t.timestamps()
    end
  end
end
