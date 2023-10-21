require "rails_helper"

RSpec.describe Admin, type: :model do
  describe "relationships" do
    it { should have_many(:shelters) }
  end

  # describe "validations" do
    
  # end

  # before(:each) do
  #   @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
  #   @shelter_2 = Shelter.create(name: "Denver shelter", city: "Denver, CO", foster_program: false, rank: 6)
  #   @shelter_3 = Shelter.create(name: "Longmont shelter", city: "Longmont, CO", foster_program: false, rank: 8)
  #   @shelter_4 = Shelter.create(name: "Boulder shelter", city: "Boulder, CO", foster_program: true, rank: 7)
  # end

  # describe "class methods" do
    
  # end
end