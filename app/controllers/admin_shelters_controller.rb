class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.order_by_name
    @pending = Shelter.pending_apps
  end
end