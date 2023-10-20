class Application < ApplicationRecord
  has_many :pet_applications

  has_many :pets, through: :pet_applications

  def empty
    if self.name == nil || self.name == ""
      true
    elsif self.address == nil || self.address == ""
      true
    elsif self.description == nil || self.description == ""
      true
    elsif
      self.status == nil || self.status == ""
      true
    else
      false
    end
  end
  
end