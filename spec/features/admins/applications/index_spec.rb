require "rails_helper"

RSpec.describe "the admin applications index" do
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

  it 'shows the id of all applications in the system and their status' do
    visit "/admin/applications"

    expect(page).to have_content(@application_1.id)
    expect(page).to have_content(@application_1.status)
  end

  it 'clicking and id takes you to admin show for that application' do
    visit "/admin/applications"

    click_link "#{@application_1.id}"

    expect(page).to have_current_path("/admin/applications/#{@application_1.id}")
  end
end