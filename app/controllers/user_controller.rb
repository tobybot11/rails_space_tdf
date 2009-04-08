class UserController < ApplicationController
  layout "site"
  
  def index
  end

  def register
    @title = "Register"
    if request.post?
      # Output goes to log file (log/development.log in development mode)
      logger.info params[:user].inspect
      
      @user = User.new(params[:user])
      if @user.save
        render :text => "User created!"
      end
    end
  end

end
