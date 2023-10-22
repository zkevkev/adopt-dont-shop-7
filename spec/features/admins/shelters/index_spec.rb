require "rails_helper"

RSpec.describe "the admin shelters index" do
  before(:each) do
    admin = Admin.create
    @shelter_1 = admin.shelters.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = admin.shelters.create(name: "Denver shelter", city: "Denver, CO", foster_program: false, rank: 6)
    @shelter_3 = admin.shelters.create(name: "Longmont shelter", city: "Longmont, CO", foster_program: false, rank: 8)
    @shelter_4 = admin.shelters.create(name: "Boulder shelter", city: "Boulder, CO", foster_program: true, rank: 7)
    @application_1 = @shelter_1.applications.create(name: "Bob", address: "123 1st St", city: "Pleasantville", state: "CO", zipcode: 80501, description: "they're cute", status: "In Progress")
  end

  
  xit 'has all shelters in system listed in reverse alphabetical order' do
    visit "/admin/shelters"

    expect(@shelter_3.name).to appear_before(@shelter_2.name)
    expect(@shelter_2.name).to appear_before(@shelter_4.name)
    expect(@shelter_4.name).to appear_before(@shelter_1.name)
  end

  it 'lists shelters with pending applications' do
    visit "/admin/shelters"
    expect(page).to have_content("Shelters with Pending Applications")
    expect("Shelters with Pending Applications").to appear_before(@shelter_4.name)
    expect("Shelters with Pending Applications").to appear_before(@shelter_1.name)
  end
end