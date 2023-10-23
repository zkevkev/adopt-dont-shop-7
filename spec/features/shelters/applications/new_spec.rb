require 'rails_helper'

RSpec.describe "shelter applications new" do
  before (:each) do
    admin = Admin.create
    @shelter = admin.shelters.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: @shelter.id)
    @pet_3 = Pet.create(adoptable: false, age: 2, breed: "saint bernard", name: "Beethoven", shelter_id: @shelter.id)
    @application_1 = @shelter.applications.create(name: "Bob", address: "123 1st St", city: "Pleasantville", state: "CO", zipcode: 80501, description: "they're cute", status: "In Progress")
  end

  it 'create an application form, create a new application record, and redirects to show' do
    visit "shelters/#{@shelter.id}/applications/new"

 
    fill_in "name", with: "#{@application_1.name}"
    fill_in "address", with: "#{@application_1.address}"
    fill_in "city", with: "#{@application_1.city}"
    fill_in "state", with: "#{@application_1.state}"
    fill_in "zipcode", with: "#{@application_1.zipcode}"
    fill_in "description", with: "#{@application_1.description}"
    click_button "Submit"

    application = Application.last

    expect(page).to have_current_path("/applications/#{application.id}")
    expect(page).to have_content(application.name)
    expect(page).to have_content(application.address)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.status)
  end

  it "tells you if the application form is incomplete" do
    visit "shelters/#{@shelter.id}/applications/new"
    fill_in "name", with: "Bob"
    fill_in "address", with: "123 1st St"
    fill_in "city", with: "Pleasantville"
    fill_in "state", with: "CO"
    fill_in "zipcode", with: "80501"

    click_button "Submit"
    
    expect(page).to have_current_path("shelters/applications")
  end
end
