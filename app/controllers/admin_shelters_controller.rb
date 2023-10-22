class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.find_by_sql "SELECT name FROM shelters ORDER BY name DESC"
    @applications = Shelter.applications
    require 'pry'; binding.pry

  end

  def pending
    @shelters = Shelter.all 

    
  end
end