class ApplicationsController < ApplicationController
  
  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    application = Application.create!({
      name: params[:name],
      address: "local",
      description: params[:description],
      status: "In Progress"
    })

    redirect_to "/applications/#{application.id}"
  end
end