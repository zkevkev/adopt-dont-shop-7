require 'rails_helper'

RSpec.describe "application show" do
  before (:each) do
    admin = Admin.create
    @shelter = admin.shelters.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: @shelter.id)
    @pet_3 = Pet.create(adoptable: false, age: 2, breed: "saint bernard", name: "Beethoven", shelter_id: @shelter.id)
    @pet_4 = Pet.create(adoptable: false, age: 5, breed: "bernese", name: "Mr. Beet", shelter_id: @shelter.id)
    @application_1 = Application.create(name: "Bob", address: "123 1st St", city: "Pleasantville", state: "CO", zipcode: 80501, description: "they're cute", status: "In Progress")
    
    @pet_1.applications << @application_1
    @pet_2.applications << @application_1
    @pet_4.applications << @application_1
  end

  it 'displays name, address, description, pets, and status for applicants' do
    visit "/applications/#{@application_1.id}"

    expect(page).to have_content(@application_1.name)
    expect(page).to have_content(@application_1.address)
    expect(page).to have_content(@application_1.description)
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@application_1.status)

    click_link("Lucille Bald") 
    expect(page).to have_current_path("/pets/#{@pet_1.id}")
  end

  it 'searches pets by name and redirects to show matches' do
    visit "/applications/#{@application_1.id}"
    within("section#search") do
      fill_in "search_app", with: "Beethoven"
      click_button "Submit"
    end
    expect(current_path).to eq("/applications/#{@application_1.id}")
    # this is a good opportunity to use a within block when refactoring
    expect(page).to have_content(@pet_3.name)
  end

  it 'search function can add pets to an application' do
    visit "/applications/#{@application_1.id}"
    within("section#search") do
      fill_in "search_app", with: "Beethoven"
      click_button "Submit"
    end
    click_button "Adopt this Pet"

    expect(@application_1.pets).to eq([@pet_1, @pet_2, @pet_3, @pet_4])

    # this goes back the the show page but with a modified url, research how to test this
    # expect(page).to have_current_path("/applications/#{@application_1.id}")
    
    # this is a good opportunity to use a within block when refactoring
    expect(page).to have_content(@pet_3.name)
  end

  it 'allows user to fill out why, submit application, and have status change to pending' do
    visit "/applications/#{@application_1.id}"

    expect(page).to_not have_content("Pending")
    expect(page).to have_content("In Progress")

    within("section#submit") do
      fill_in "description", with: "I love animals"
      click_button "Submit"
    end

    expect(page).to have_current_path("/applications/#{@application_1.id}")
    expect(page).to have_content("Pending")
    expect(page).to_not have_content("In Progress")
    expect(page).to_not have_content("Add a Pet to this Application")
    expect(page).to_not have_content("Why would you make a good owner for these pet(s)?")
    # expect(page).to_not have_content("Why would you make a good owner for these pet(s)?")
  end

  it 'cannot submit if there are no pets' do
    visit "/applications/#{@application_1.id}"
    
    expect(find_field("search_app").value).to eq(nil)
    expect(page).to_not have_link("Submit")

    #Is this really all that is necessary? I feel like this is too simplistic for 7
  end

  it 'allows for partial searches' do
    visit "/applications/#{@application_1.id}"
    
    within("section#search") do
      fill_in "search_app", with: "Beethov"
      click_button "Submit"
    end
    
    expect(current_path).to eq("/applications/#{@application_1.id}")
    
    expect(page).to have_content(@pet_3.name)
    expect(page).to have_content(@pet_4.name)
  end
  
  it 'has a case insensitive search' do
    visit "/applications/#{@application_1.id}"
    
    within("section#search") do
      fill_in "search_app", with: "lOBsTeR"
      click_button "Submit"
    end
    
    expect(current_path).to eq("/applications/#{@application_1.id}")
    
    expect(page).to have_content(@pet_2.name)
  end
end