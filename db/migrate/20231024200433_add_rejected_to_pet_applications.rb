class AddRejectedToPetApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :pet_applications, :rejected, :boolean, default: false
  end
end
