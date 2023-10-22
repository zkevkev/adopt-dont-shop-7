class CreateJoinTableSheltersApplications < ActiveRecord::Migration[7.0]
  def change
    create_join_table :shelters, :applications do |t|
      # t.index [:shelter_id, :application_id]
      # t.index [:application_id, :shelter_id]
    end
  end
end
