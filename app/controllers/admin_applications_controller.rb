class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])

    if params[:approved].present?

    end
  end
end