class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.find_by_sql "SELECT name FROM shelters ORDER BY name DESC"
  end
end