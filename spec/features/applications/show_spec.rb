require 'rails_helper'

RSpec.describe "application show" do
  before (:each) do
    @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: @shelter.id)
    @pet_3 = Pet.create(adoptable: false, age: 2, breed: "saint bernard", name: "Beethoven", shelter_id: @shelter.id)
    @application_1 = Application.create(name: "Bob", address: "123 1st St", city: "Pleasantville", state: "CO", zipcode: 80501, description: "they're cute", status: "In Progress")
    
    @pet_1.applications << @application_1
    @pet_2.applications << @application_1
  end

  it 'displays name, address, description, pets, and status for applicants' do
    visit "/applications/#{@application_1.id}"

    expect(page).to have_content(@application_1.name)
    expect(page).to have_content(@application_1.address)
    expect(page).to have_content(@application_1.description)
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@application_1.status)

    click_link("Lucille Bald") 
    expect(current_path).to eq("/pets/#{@pet_1.id}")
  end

  it 'searches pets by name and redirects to show matches' do
    visit "/applications/#{@application_1.id}"
    fill_in "search_app", with: "Beethoven"
    click_button "Submit"

    expect(current_path).to eq("/applications/#{@application_1.id}")
    expect(page).to have_content(@pet_3.name)
  end

  xit 'allows user to fill out why, submit application, and have status change to pending' do
    #     As a visitor
    # When I visit an application's show page
    visit "/applications/#{@application_1.id}"
    # And I have added one or more pets to the application
    check "#{@pet_3.name}"
    check "#{@pet_1.name}"
    # Then I see a section to submit my application
    # And in that section I see an input to enter why I would make a good owner for these pet(s)
    # When I fill in that input
    fill_in "description", with: "I love animals"
    # And I click a button to submit this application
    expect(page).to have_content("In Progress")
    expect(page).to_not have_content("Pending")
    click_button "Submit"
    # expect(current_path).to eq("/applications/#{@application_1.id}")
    expect(page).to have_current_path("/applications/#{@application_1.id}")
    # Then I am taken back to the application's show page
    # And I see an indicator that the application is "Pending"
    expect(page).to have_content("Pending")
    expect(page).to_not have_content("In Progress")
    # And I see all the pets that I want to adopt
    # And I do not see a section to add more pets to this application
  end
end