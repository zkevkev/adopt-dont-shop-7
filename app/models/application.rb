class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true, numericality: true
  validates :description, presence: true

  def add_pet(pet_id)
    pet = Pet.find(pet_id)
    pets << pet
  end
end
