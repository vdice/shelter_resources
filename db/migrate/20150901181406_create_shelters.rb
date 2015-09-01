class CreateShelters < ActiveRecord::Migration
  def change
    create_table(:shelters) do |t|
      t.column(:name, :string)
      t.column(:location, :string)

      t.timestamps()
    end
  end
end
