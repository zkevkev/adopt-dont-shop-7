class AddCityStateZipToApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :applications, :city, :string
    add_column :applications, :state, :string
    add_column :applications, :zipcode, :integer
  end
end
