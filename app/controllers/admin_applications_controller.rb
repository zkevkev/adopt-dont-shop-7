class AdminApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end
  
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def update
    pet = Pet.find(params[:pet_id])
    application = Application.find(params[:id])
    pet_application = PetApplication.where("pet_id = #{pet.id}", "application_id = #{application.id}")
    pet_application.update({ approved: params[:approved], rejected: params[:rejected] })

    redirect_to "/admin/applications/#{application.id}"
  end
end