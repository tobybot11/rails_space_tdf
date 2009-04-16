require 'digest/sha1'
class User < ActiveRecord::Base
  attr_accessor :remember_me
  
  # Max & min lengths for all fields
  SCREEN_NAME_MIN_LENGTH = 4
  SCREEN_NAME_MAX_LENGTH = 20
  PASSWORD_MIN_LENGTH = 4
  PASSWORD_MAX_LENGTH = 40
  EMAIL_MAX_LENGTH = 50
  SCREEN_NAME_RANGE = SCREEN_NAME_MIN_LENGTH..SCREEN_NAME_MAX_LENGTH
  PASSWORD_RANGE = PASSWORD_MIN_LENGTH..PASSWORD_MAX_LENGTH
  
  # Text box sizes for display in the views
  SCREEN_NAME_SIZE = 20
  PASSWORD_SIZE = 10 
  EMAIL_SIZE = 30
  
  validates_uniqueness_of :screen_name, :email
  validates_length_of     :screen_name, :within => SCREEN_NAME_RANGE
  validates_length_of     :password,    :within => PASSWORD_RANGE
  validates_length_of     :email,       :maximum => EMAIL_MAX_LENGTH
  
  validates_format_of :screen_name,
                      :with => /^[A-Z0-9_]*$/i,
                      :message => "must contain only letters, " +
                                  "numbers, and underscores"
                                  
  validates_format_of :email,
                      :with => /^[A-Z0-9._%-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i,
                      :message => 'must be a valid email address'
                      
  # Log a user in
  def login!(session)
    session[:user_id] = id
  end
  
  # Log a user out
  def self.logout!(session, cookies)
    session[:user_id] = nil
    cookies.delete(:authorization_token)
  end
  
  # Clear the password (typically to suppress it's display in a view)
  def clear_password!
    self.password = nil
  end
  
  # Remember a user for future login
  def remember!(cookies)
    cookie_expiration = 10.years.from_now
    # the box is check so set the remember_me cookie.
    cookies[:remember_me] = { :value => "1", :expires => cookie_expiration }

    self.authorization_token = unique_identifier
    save!
  
    cookies[:authorization_token] = { :value => authorization_token, 
      :expires => cookie_expiration 
    }
  end
  
  # Forget a users' login status.
  def forget!(cookies)
    cookies.delete(:remember_me)
    cookies.delete(:authorization_token)
  end

  # Return true if the user wants the login status remembered.
  def remember_me?
    remember_me == "1"
  end
  
  private

  # Generate a unique identifier for a user.
  def unique_identifier
    Digest::SHA1.hexdigest("#{screen_name}:#{password}")
  end
  
end
