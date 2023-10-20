class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true
  validates :description, presence: true



  def empty?
    if self.name == nil || self.name == ""
      true
    elsif self.address == nil || self.address == ""
      true
    elsif self.city == nil || self.city == ""
      true
    elsif self.state == nil || self.state == ""
      true
    elsif self.zipcode == nil || self.zipcode == ""
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