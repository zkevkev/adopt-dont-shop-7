class ApplicationsController < ApplicationController
  
  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    application = Application.create!({
      name: params[:name],
      address: params[:address],
      description: params[:description],
      status: "In Progress"
    })
    if application.empty == true
      redirect_to "/applications/new"
    else
    redirect_to "/applications/#{application.id}"
    end
  end
end