class PetApplication < ApplicationRecord 
  belongs_to :pet
  belongs_to :application

  def self.approved_pets(application_id)
    where("application_id = #{application_id}, approved = true")
  end
end