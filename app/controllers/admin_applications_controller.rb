class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    pet = Pet.find(params[:pet_id])
    application = Application.find(params[:id])
    pet_application = PetApplication.where("pet_id = #{pet.id}", "application_id = #{application.id}")
    pet_application.update({ approved: params[:approved] })
    
    redirect_to ""
  end
end