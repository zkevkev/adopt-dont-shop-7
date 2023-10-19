class Application < ApplicationRecord
  has_many :pet_applications
  require 'pry'; binding.pry
  has_many :pets, through: :pet_applications
  
end