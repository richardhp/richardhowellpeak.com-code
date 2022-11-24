class Admin::AdminController < ApplicationController
  layout 'admin/application'
  before_action :require_login
  skip_before_action :require_login, only: [:index, :logout, :login, :login_page]

  def index 
    unless logged_in? 
      redirect_to admin_login_path
    end
  end

  def login_page
   
  end

  def login 
    if attempt_login(params)
      redirect_to admin_root_path
    else
      redirect_to admin_login_path 
    end
  end

  def logout
    session[:logged_in] = false
    redirect_to admin_login_path 
  end

  private
 
  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to admin_login_path
    end
  end

  def attempt_login(params)
    user = AdminUser.find_by(email: params[:email])
    if ! user.present? || ! user.authenticate(params[:password])
      session[:logged_in] = false
    else
      session[:logged_in] = true
    end
    session[:logged_in]
  end

  def logged_in?
    session[:logged_in]
  end

end