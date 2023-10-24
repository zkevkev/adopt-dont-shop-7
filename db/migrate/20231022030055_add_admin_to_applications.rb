class AddAdminToApplications < ActiveRecord::Migration[7.0]
  def change
    add_reference :applications, :admin, null: false, foreign_key: true
  end
end
