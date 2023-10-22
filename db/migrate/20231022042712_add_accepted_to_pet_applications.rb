class AddAcceptedToPetApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :pet_applications, :accepted, :boolean
  end
end
