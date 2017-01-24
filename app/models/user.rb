class User < ActiveRecord::Base
  validates_presence_of :full_name, :password_digest, :email
end