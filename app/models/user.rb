class User < ActiveRecord::Base
  validates_uniqueness_of :screen_name, :email
  validates_length_of     :screen_name, :within => 4..20
  validates_length_of     :password,    :within => 4..40
  validates_length_of     :email,       :maximum => 50
  validates_presence_of   :email
end
