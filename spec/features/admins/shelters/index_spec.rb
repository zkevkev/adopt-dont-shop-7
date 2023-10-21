require "rails_helper"

RSpec.describe "the admin shelters index" do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "Denver shelter", city: "Denver, CO", foster_program: false, rank: 6)
    @shelter_3 = Shelter.create(name: "Longmont shelter", city: "Longmont, CO", foster_program: false, rank: 8)
    @shelter_4 = Shelter.create(name: "Boulder shelter", city: "Boulder, CO", foster_program: true, rank: 7)
  end

  
  it 'has all shelters in system listed in reverse alphabetical order' do
    visit "/admin/shelters"

    expect(@shelter_3.name).to appear_before(@shelter_2.name)
    expect(@shelter_2.name).to appear_before(@shelter_4.name)
    expect(@shelter_4.name).to appear_before(@shelter_1.name)
  end
end