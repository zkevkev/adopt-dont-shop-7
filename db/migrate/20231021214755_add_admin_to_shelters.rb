class AddAdminToShelters < ActiveRecord::Migration[7.0]
  def change
    add_reference :shelters, :admin, null: false, foreign_key: true
  end
end
