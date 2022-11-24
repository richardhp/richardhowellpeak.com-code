class DrugsController < ApplicationController

  def home
  end
  
  def training 
    if flash[:email].nil?
      redirect_to '/drugs'
    end
  end

  def training_register
    volunteer = Volunteer.where(email: params[:email]).first_or_create
    flash[:email] = params[:email]

    redirect_to '/drugs/training'
  end

end