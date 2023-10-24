class Admin < ApplicationRecord
  has_many :shelters
  has_many :applications
end