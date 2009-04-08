class UserController < ApplicationController
  layout "site"
  
  def index
  end

  def register
    @title = "Register"
    if request.post? and params[:user]
      # Output goes to log file (log/development.log in development mode)
      logger.info params[:user].inspect
      # just in case! raise params[:user].inspect
      
      @user = User.new(params[:user])
      if @user.save
        flash[:notice] = "User #{@user.screen_name} created!"
        redirect_to :action => "index"
      end
    end
  end

end
