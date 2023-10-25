class PetApplication < ApplicationRecord 
  belongs_to :pet
  belongs_to :application

  # def self.find_pet_app(pet_id, application_id)
  #   PetApplication.where("pet_id = #{pet_id}", "application_id = #{application_id}")
  # end
end