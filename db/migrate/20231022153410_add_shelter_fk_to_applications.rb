class AddShelterFkToApplications < ActiveRecord::Migration[7.0]
  def change
    add_reference :applications, :shelter, foreign_key: true
  end
end
