class ApplicationsController < ApplicationController
  
  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    @application = Application.create!({
      name: params[:name],
      address: params[:address],
      city: params[:city],
      state: params[:state],
      zipcode: params[:zipcode],
      description: params[:description],
      status: "In Progress"
    })
    require 'pry'; binding.pry
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      render :new
    end
  end
end