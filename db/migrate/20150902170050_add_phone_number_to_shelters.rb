class AddPhoneNumberToShelters < ActiveRecord::Migration
  def change
    add_column(:shelters, :phone_number, :string)
  end
end
