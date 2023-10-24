class AdminSheltersController < ApplicationController
  def index
    @shelters_pending = Shelter.all


    # @applications = Application.all 
    @shelters = Shelter.order_by_name
  end


end