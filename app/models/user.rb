class User < ActiveRecord::Base
  
  # Max & min lengths for all fields
  SCREEN_NAME_MIN_LENGTH = 4
  SCREEN_NAME_MAX_LENGTH = 20
  PASSWORD_MIN_LENGTH = 4
  PASSWORD_MAX_LENGTH = 40
  EMAIL_MAX_LENGTH = 50
  SCREEN_NAME_RANGE = SCREEN_NAME_MIN_LENGTH..SCREEN_NAME_MAX_LENGTH
  PASSWORD_RANGE = PASSWORD_MIN_LENGTH..PASSWORD_MAX_LENGTH
  
  validates_uniqueness_of :screen_name, :email
  validates_length_of     :screen_name, :within => SCREEN_NAME_RANGE
  validates_length_of     :password,    :within => PASSWORD_RANGE
  validates_length_of     :email,       :maximum => EMAIL_MAX_LENGTH
  
  def validate
    errors.add(:email, "must be valid at symbol.") unless email.include? ("@")
    if screen_name.include?(" ")
      errors.add(:screen_name, "cannot include spaces.")
    end
  end
end
