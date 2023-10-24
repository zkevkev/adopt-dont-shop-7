require "rails_helper"

RSpec.describe "the admin shelters index" do
  before(:each) do
    admin = Admin.create
    @shelter_1 = admin.shelters.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = admin.shelters.create(name: "Denver shelter", city: "Denver, CO", foster_program: false, rank: 6)
    @shelter_3 = admin.shelters.create(name: "Longmont shelter", city: "Longmont, CO", foster_program: false, rank: 8)
    @shelter_4 = admin.shelters.create(name: "Boulder shelter", city: "Boulder, CO", foster_program: true, rank: 7)
    
    @application_2 = Application.create(name: "Brendan", address: "123 1st St", city: "Denver", state: "CO", zipcode: 80207, description: "they're fun", status: "Pending")
    @application_3 = Application.create(name: "Kevin", address: "456 A st", city: "Longmont", state: "CO", zipcode: 80501, description: "they're cute", status: "Pending")
    @application_4 = Application.create(name: "Joe", address: "87 2nd st", city: "New York", state: "NY", zipcode: 98787, description: "they're cute", status: "In Progress")

    @pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: @shelter_4.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: @shelter_1.id)
    @pet_3 = Pet.create(adoptable: false, age: 2, breed: "saint bernard", name: "Beethoven", shelter_id: @shelter_1.id)
    
    @pet_1.applications << @application_2
    @pet_2.applications << @application_3
    @pet_3.applications << @application_4

  end

  
  it 'has all shelters in system listed in reverse alphabetical order' do
    visit "/admin/shelters"

    expect(@shelter_3.name).to appear_before(@shelter_2.name)
    expect(@shelter_2.name).to appear_before(@shelter_4.name)
    expect(@shelter_4.name).to appear_before(@shelter_1.name)
  end

  it 'lists shelters with pending applications' do
    visit "/admin/shelters"
    expect(page).to have_content("Shelters with Pending Applications")
    within("section#pending") do 
      expect("Shelters with Pending Applications").to appear_before(@shelter_4.name)
      expect("Shelters with Pending Applications").to appear_before(@shelter_1.name)
    end
  end
end