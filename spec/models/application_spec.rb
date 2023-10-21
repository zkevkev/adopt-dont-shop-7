require "rails_helper"

RSpec.describe Application, type: :model do
    describe "relationships with pets and pet_applications" do
      it { should have_many :pet_applications }
      it { should have_many(:pets).through(:pet_applications) }
    end

    describe "validate all fields in the form", type: :model do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:address) }
      it { should validate_presence_of(:city) }
      it { should validate_presence_of(:state) }
      it { should validate_presence_of(:zipcode) }
      it { should validate_presence_of(:description) }
    end

    describe 'instance methods' do
      describe '.add_pet' do
        it 'adds a pet to the application' do
          application = Application.create(name: "Bob", address: "123 1st St", city: "Pleasantville", state: "CO", zipcode: 80501, description: "they're cute", status: "In Progress")
          admin = Admin.create
          shelter = admin.shelters.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
          pet = Pet.create(adoptable: false, age: 2, breed: "saint bernard", name: "Beethoven", shelter_id: shelter.id)

          application.add_pet(pet.id)

          expect(application.pets).to eq([pet])
        end
      end
    end
  end
  