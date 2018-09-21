class User < ApplicationRecord

  # Association
  has_many :sessions

  has_secure_password


end
