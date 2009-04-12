class UserController < ApplicationController
#  layout "site"
  
  def index

    @title = "RailsSpace User Hub"
    # This will be a protected page for viewing user information.
  end

  def login
    @title = "Log in to RailsSpace"
    if request.post? and params[:user]
      @user = User.new(params[:user])
      user = User.find_by_screen_name_and_password(@user.screen_name, @user.password)
      if user
        session[:user_id] = user.id
        flash[:notice] = "User #{user.screen_name} logged in!"
        redirect_to :action => 'index'
      else
        # Don't show the password in the view.
        @user.password = nil
        flash[:notice] = "Invalid screen name/password combination"
      end
    end
  end
  
  def logout
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to :action => "index", :controller => "site"
  end
  
  def register
    @title = "Register"
    if request.post? and params[:user]
      # Output goes to log file (log/development.log in development mode)
      logger.info params[:user].inspect
      # just in case! raise params[:user].inspect
      
      @user = User.new(params[:user])
      if @user.save
        session[:user_id] = @user.id
        flash[:notice] = "User #{@user.screen_name} created!"
        redirect_to :action => "index"
      end
    end
  end
  
  private
  
  def protect
    unless session[:user_id]
      flash[:notice] = "Please log in first"
      redirect_to :action => "login"
      return false
    end
  end
end
