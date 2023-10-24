require "rails_helper"

RSpec.describe "the admin application show" do
  before (:each) do
    admin = Admin.create
    @shelter = admin.shelters.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    
    @application_1 = Application.create(name: "Brendan", address: "123 1st St", city: "Denver", state: "CO", zipcode: 80207, description: "they're fun", status: "Pending")
    # @application_3 = Application.create(name: "Kevin", address: "456 A st", city: "Longmont", state: "CO", zipcode: 80501, description: "they're cute", status: "Pending")
    # @application_4 = Application.create(name: "Joe", address: "87 2nd st", city: "New York", state: "NY", zipcode: 98787, description: "they're cute", status: "In Progress")

    @pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: @shelter.id)
    @pet_3 = Pet.create(adoptable: false, age: 2, breed: "saint bernard", name: "Beethoven", shelter_id: @shelter.id)
    
    @pet_1.applications << @application_1
    @pet_2.applications << @application_1
    @pet_3.applications << @application_1
  end

  xit 'has a button to approve each application for each pet' do
    visit "/admin/applications/#{@application_1.id}"

    expect(page).to have_button("Approve #{@pet_1.name}")
    expect(page).to have_button("Approve #{@pet_2.name}")
    expect(page).to have_button("Approve #{@pet_3.name}")
  
  end

  it 'clicks the button, takes user back, button is removed for that pet, and is replaced with approval' do
    visit "/admin/applications/#{@application_1.id}"

    click_button("Approve #{@pet_1.name}")
    expect(current_path).to eq("/admin/applications/#{@application_1.id}")
    expect(page).to_not have_button("Approve #{@pet_1.name}")
    expect(page).to have_content("#{@pet_1.name}'s application has been approved")

  
  end
  # For every pet that the application is for, I see a button to approve the application for that specific pet
  # When I click that button
  # Then I'm taken back to the admin application show page
  # And next to the pet that I approved, I do not see a button to approve this pet
  # And instead I see an indicator next to the pet that they have been approved
  
end