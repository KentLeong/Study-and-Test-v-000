class User < ActiveRecord::Base
  has_secure_password

  has_many :tests
  has_many :studies, through: :tests
end
