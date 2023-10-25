require "rails_helper"

RSpec.describe Shelter, type: :model do
  describe "relationships" do
    it { should have_many(:pets) }
    it { should belong_to(:admin) }
    it { should have_many(:applications).through(:pets)}
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:rank) }
    it { should validate_numericality_of(:rank) }
  end

  before(:each) do
    @admin = Admin.create

    @shelter_1 = @admin.shelters.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = @admin.shelters.create(name: "RGV animal @admin.shelters", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = @admin.shelters.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

    @application_1 = @admin.applications.create(name: "Brendan", address: "123 1st St", city: "Denver", state: "CO", zipcode: 80207, description: "they're fun", status: "Pending")
    @application_2 = @admin.applications.create(name: "Kevin", address: "456 A st", city: "Longmont", state: "CO", zipcode: 80501, description: "they're cute", status: "Pending")
    @application_3 = @admin.applications.create(name: "Joe", address: "87 2nd st", city: "New York", state: "NY", zipcode: 98787, description: "they're cute", status: "In Progress")

    @pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)

    @pet_1.applications << @application_1
    @pet_2.applications << @application_2
    @pet_3.applications << @application_3
  end

  describe "class methods" do
    describe ".search" do
      it "returns partial matches" do
        expect(Shelter.search("Fancy")).to eq([@shelter_3])
      end
    end

    describe ".order_by_recently_created" do
      it "returns shelters with the most recently created first" do
        expect(Shelter.order_by_recently_created).to eq([@shelter_3, @shelter_2, @shelter_1])
      end
    end

    describe ".order_by_number_of_pets" do
      it "orders the shelters by number of pets they have, descending" do
        expect(Shelter.order_by_number_of_pets).to eq([@shelter_1, @shelter_3, @shelter_2])
      end
    end

    describe '.order_by_name' do
      it 'orders the shelters by name, descending' do
        expect(Shelter.order_by_name).to eq([@shelter_2, @shelter_3, @shelter_1])
      end
    end

    describe '.pending_apps' do
      it 'returns a list of all shelter names that have pending applications' do
        expect(Shelter.pending_apps).to eq(@shelter_1.name)
      end
    end
  end

  describe "instance methods" do
    describe "#adoptable_pets" do
      it "only returns pets that are adoptable" do
        expect(@shelter_1.adoptable_pets).to eq([@pet_2, @pet_4])
      end
    end

    describe "#alphabetical_pets" do
      it "returns pets associated with the given shelter in alphabetical name order" do
        expect(@shelter_1.alphabetical_pets).to eq([@pet_4, @pet_2])
      end
    end

    describe "#shelter_pets_filtered_by_age" do
      it "filters the shelter pets based on given params" do
        expect(@shelter_1.shelter_pets_filtered_by_age(5)).to eq([@pet_4])
      end
    end

    describe "#pet_count" do
      it "returns the number of pets at the given shelter" do
        expect(@shelter_1.pet_count).to eq(3)
      end
    end
  end
end
