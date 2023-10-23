class AdminSheltersController < ApplicationController
  def index
    @shelters_pending = Shelter.all
    require 'pry'; binding.pry
    # require 'pry'; binding.pry


    # @applications = Application.all 
    @shelters = Shelter.find_by_sql "SELECT name FROM shelters ORDER BY name DESC"
  end


end