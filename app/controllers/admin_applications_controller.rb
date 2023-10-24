class AdminApplicationsController < ApplicationController
  def show
    # require 'pry'; binding.pry
    @application = Application.find(params[:id])
    @pets = @application.pets
    @approved_pets = @application.pet_applications
    require 'pry'; binding.pry
  end

  def update

  end

end