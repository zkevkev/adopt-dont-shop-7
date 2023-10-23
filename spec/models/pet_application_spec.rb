require "rails_helper"

RSpec.describe PetApplication, type: :model do
  describe "relationships" do
    it { should belong_to(:pet) }
    it { should belong_to(:application) }
  end

  before(:each) do
    @application = Application.create(name: "Bob", address: "123 1st St", city: "Pleasantville", state: "CO", zipcode: 80501, description: "they're cute", status: "In Progress")
    admin = Admin.create
    @shelter = admin.shelters.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @pet_1 = @shelter.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @pet_2 = @shelter.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter.pets.create(name: "Ann", breed: "ragdoll", age: 3, adoptable: false)

    @application.pets << @pet_1
    @application.pets << @pet_2
    @application.pets << @pet_3
  end

  describe "class methods" do
    describe ".approved_pets" do
      it "returns a list of approved pets for a given application id" do        
        expect(PetApplication.approved_pets(@application.id)).to eq("")
      end
    end
  end
end