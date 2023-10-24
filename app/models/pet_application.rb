class PetApplication < ApplicationRecord 
  belongs_to :pet
  belongs_to :application

  def approved?
    self.approved
  end

  def get_id
    require 'pry'; binding.pry
    self.pluck(:pet_id)
  end


end