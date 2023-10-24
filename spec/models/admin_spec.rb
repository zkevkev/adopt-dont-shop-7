require "rails_helper"

RSpec.describe Admin, type: :model do
  describe "relationships" do
    it { should have_many(:shelters) }
    it { should have_many(:applications) }
  end

  # before(:each) do

  # end

  # describe "class methods" do
    
  # end
end