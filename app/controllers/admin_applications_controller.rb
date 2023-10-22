class AdminApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end
  
  def show
    @application = Application.find(params[:id])
    @all_pet_apps = PetApplication.where("application_id = #{@application.id}").order(updated_at: :desc)
    # @pet_application = @all_pet_apps.first
    @approved_apps = @all_pet_apps.select do |pet_app|
      pet_app.approved
    end

    # if params[:approved].present?
    #   pet = Pet.find(params[:pet_id])
    #   @pet_application = PetApplication.where("pet_id = #{pet.id}", "application_id = #{application.id}")
    # end
  end

  def update
    pet = Pet.find(params[:pet_id])
    application = Application.find(params[:id])
    pet_application = PetApplication.where("pet_id = #{pet.id}", "application_id = #{application.id}")
    pet_application.update({ approved: params[:approved] })

    redirect_to "/admin/applications/#{application.id}"
  end
end