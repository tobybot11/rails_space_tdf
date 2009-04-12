require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users

  def setup
    @error_messages = I18n.translate("activerecord.errors.messages")
    @valid_user = users(:valid_user)
    @invalid_user = users(:invalid_user)
  end
      
  # This user should be valid by construction.
  def test_user_validity
    assert @valid_user.valid?
  end
  
  # This user shold be invalid by construction.
  def test_user_invalidity
    assert !@invalid_user.valid?
    
    attributes = [:screen_name, :email, :password]
    attributes.each do |attribute|
      assert @invalid_user.errors.invalid?(attribute)
    end
  end
  
  def test_uniqueness_of_screen_name_and_email
    user_repeat = User.new(:screen_name => @valid_user.screen_name,
      :email => @valid_user.email, :password => @valid_user.password)
    
    assert !user_repeat.valid?
    assert_equal @error_messages[:taken], user_repeat.errors.on(:screen_name)
    assert_equal @error_messages[:taken], user_repeat.errors.on(:email)
  end
  
  # Make sure the screen name can't be too short.
  def test_screen_name_minimum_length
    user = @valid_user
    min_length = User::SCREEN_NAME_MIN_LENGTH
    
    # Screen name is too short.
    user.screen_name = "a" * (min_length - 1)
    assert !user.valid?, "#{user.screen_name} should raise a minimum length error"
    # Format the error message based on minimum length.
    correct_error_message = I18n.t "activerecord.errors.messages.too_short", :count => min_length
    assert_equal correct_error_message, user.errors.on(:screen_name)
    
    # Screen name is minimum length.
    user.screen_name = "a" * min_length
    assert user.valid?, "#{user.screen_name} should be just long enough to pass"
  end
  
  def test_screen_name_maximum_length
    user = @valid_user
    max_length = User::SCREEN_NAME_MAX_LENGTH
    
    # Screen name is too long.
    user.screen_name = "a" * (max_length + 1)
    assert !user.valid?, "#{user.screen_name} should raise a maximum length error"
    # Format the error message based on maximum length.
    correct_error_message = I18n.t "activerecord.errors.messages.too_long", :count => max_length
    assert_equal correct_error_message, user.errors.on(:screen_name)
    
    # Screen name is maximum length.
    user.screen_name = "a" * max_length
    assert user.valid?, "#{user.screen_name} should be just short enough to pass"
  end
  
  # Make sure the password can't be too short.
  def test_password_minimum_length
    user = @valid_user
    min_length = User::PASSWORD_MIN_LENGTH
    
    # Password is too short
    user.password = "a" * (min_length - 1)
    assert !user.valid?, "#{user.password} should raise a minimum length error"
    # Format the error message based on minimum length.
    correct_error_message = I18n.t "activerecord.errors.messages.too_short", :count => min_length
    assert_equal correct_error_message, user.errors.on(:password)
    
    # Password is just long enough.
    user.password = "a" * min_length
    assert user.valid?, "#{user.password} should be just long enough to pass"
  end

  # Make sure the password can't be too long
  def test_password_maximum_length
      user = @valid_user
      max_length = User::PASSWORD_MAX_LENGTH
      
      # Password is too long.
      user.password = "a" * (max_length + 1)
      assert !user.valid?, "#{user.password} should raise a maximum length error"
      # Format the error message based on maximum length
      correct_error_message = I18n.t "activerecord.errors.messages.too_long", :count => max_length
      assert_equal correct_error_message, user.errors.on(:password)
      
      # Passowrd is maximum length.
      user.password = "a" * max_length
      assert user.valid?, "#{user.password} should be just short enough to pass"
  end
  
  # Make sure email can't be too long
  def test_email_maximum_length
    user = @valid_user
    max_length = User::EMAIL_MAX_LENGTH
    
    # Construct a valid email that is too long.
    user.email = "a" * (max_length - user.email.length + 1) + user.email
    assert !user.valid?, "#{user.email} should raise a maximum length error"
    # Format the error message based on maximum length
    correct_error_message = I18n.t "activerecord.errors.messages.too_long", :count => max_length
    assert_equal correct_error_message, user.errors.on(:email)
  end
  
  test "the truth" do
    assert true
  end
end
