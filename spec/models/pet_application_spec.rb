require "rails_helper"

RSpec.describe PetApplication, type: :model do
  describe "relationships" do
    it { should belong_to(:pet) }
    it { should belong_to(:application) }
  end

  before(:each) do
    admin = Admin.create
    @application = admin.applications.create(name: "Bob", address: "123 1st St", city: "Pleasantville", state: "CO", zipcode: 80501, description: "they're cute", status: "In Progress")
    @shelter = admin.shelters.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @pet_1 = @shelter.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @pet_2 = @shelter.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter.pets.create(name: "Ann", breed: "ragdoll", age: 3, adoptable: false)

    @application.pets << @pet_1
    @application.pets << @pet_2
    @application.pets << @pet_3
  end

  describe 'class methods' do
    describe '.find_pet_app' do
      it 'returns a pet_application when given an application id and a pet id' do
        query = PetApplication.find_pet_app(@application.id, @pet_1.id)
        
        require 'pry'; binding.pry
      end
    end
  end
end