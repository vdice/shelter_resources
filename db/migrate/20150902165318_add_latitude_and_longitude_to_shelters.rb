class AddLatitudeAndLongitudeToShelters < ActiveRecord::Migration
  def change
    add_column(:shelters, :latitude, :float)
    add_column(:shelters, :longitude, :float)
    rename_column(:shelters, :location, :address)
  end
end
