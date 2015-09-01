class CreateResources < ActiveRecord::Migration
  def change
    create_table(:resources) do |t|
      t.column(:type, :string)

      t.timestamps()
    end
  end
end
