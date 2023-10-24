require "rails_helper"

RSpec.describe "the admin applications show" do
  before(:each) do
    admin = Admin.create
    @application_1 = admin.applications.create(name: "Bob", address: "123 1st St", city: "Pleasantville", state: "CO", zipcode: 80501, description: "they're cute", status: "In Progress")
    @shelter = admin.shelters.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

    @pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: @shelter.id)
    @pet_3 = Pet.create(adoptable: false, age: 2, breed: "saint bernard", name: "Beethoven", shelter_id: @shelter.id)
    
    @pet_1.applications << @application_1
    @pet_2.applications << @application_1
  end

  it 'shows every pet associated with the application' do
    visit "/admin/applications/#{@application_1.id}"

    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)
    expect(page).to_not have_content(@pet_3.name)
  end

  it 'can approve a pet for adoption' do
    visit "/admin/applications/#{@application_1.id}"

    within("section#pet#{@pet_1.id}") do
      click_button "Approve this Pet"
    end
save_and_open_page
    within("section#pet#{@pet_1.id}") do
      expect(page).to have_content("This pet is approved")
      expect(page).to_not have_content("Approve this Pet")
    end
  end
end
