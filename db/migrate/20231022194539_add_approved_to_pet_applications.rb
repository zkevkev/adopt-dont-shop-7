class AddApprovedToPetApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :pet_applications, :approved, :boolean
  end
end
