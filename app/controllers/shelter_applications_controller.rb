class ShelterApplicationsController < ApplicationController
  def new
    @shelter = Shelter.find(params[:id])
  end
  
  def create
    shelter = Shelter.find(params[:id])
    @application = shelter.applications.create({
      name: params[:name],
      address: params[:address],
      city: params[:city],
      state: params[:state],
      zipcode: params[:zipcode],
      description: params[:description],
      status: "In Progress"
    })

    if @application.valid?
      redirect_to "/applications/#{@application.id}"
    else 
      @application.save
      render :new
    end
  end
end