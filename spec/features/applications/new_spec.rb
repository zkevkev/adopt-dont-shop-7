require 'rails_helper'

RSpec.describe "application new" do
  before (:each) do
    admin = Admin.create
    @shelter = admin.shelters.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: @shelter.id)
    @pet_3 = Pet.create(adoptable: false, age: 2, breed: "saint bernard", name: "Beethoven", shelter_id: @shelter.id)
  end

  it 'create an application form, create a new application record, and redirects to show' do
    visit "/applications/new"
    fill_in "name", with: "Bob"
    fill_in "address", with: "123 1st St"
    fill_in "city", with: "Pleasantville"
    fill_in "state", with: "CO"
    fill_in "zipcode", with: "80501"
    fill_in "description", with: "they're cute"
    click_button "Submit"

    application = Application.last

    expect(page).to have_current_path("/applications/#{application.id}")
    expect(page).to have_content(application.name)
    expect(page).to have_content(application.address)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.status)
  end

  it "tells you if the application form is incomplete" do
    visit "/applications/new"
    fill_in "name", with: "Bob"
    fill_in "address", with: "123 1st St"
    fill_in "city", with: "Pleasantville"
    fill_in "state", with: "CO"
    fill_in "zipcode", with: "80501"

    click_button "Submit"
    
    expect(page).to have_current_path("/applications")
  end
end
