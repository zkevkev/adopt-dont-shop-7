class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if params[:search_app].present?
      @pets = Pet.search(params[:search_app])
    end

    if params[:pet_id].present?
      @application.add_pet(params[:pet_id])  
    end
  end

  def new
    # require 'pry'; binding.pry
  end

  def create
    # require 'pry'; binding.pry
    @application = Application.create({
      name: params[:name],
      address: params[:address],
      city: params[:city],
      state: params[:state],
      zipcode: params[:zipcode],
      description: params[:description],
      status: "In Progress"
    })
    # require 'pry'; binding.pry
    if @application.valid?
      redirect_to "/applications/#{@application.id}"
    else 
      @application.save
      render :new
    end
  end

  def update
    application = Application.find(params[:id])
    application.update({
      status: params[:status],
      # this part almost certainly doesn't work, pry in and find out
      description: params[:description]
    })

    redirect_to "/applications/#{application.id}"
  end
end