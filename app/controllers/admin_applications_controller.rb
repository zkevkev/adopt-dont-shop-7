class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    #pet_ids = @pets.map { |pet| pet.id} --This gets the pet IDs
    @pet_apps = @application.pet_applications
    # pet_app_ids = @pet_apps.map { |pet_app| pet_app.pet_id} --This gets pet application IDs
    
    @approved = @pet_apps.map { |pet_app| pet_app.id if pet_app.approved.present? }
    #default of approved should probably be changed from nil
    require 'pry'; binding.pry
  end

  def update

  end

end