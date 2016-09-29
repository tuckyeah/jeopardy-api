class User < ActiveRecord::Base
  include Authentication
  has_many :examples
  has_many :games
  has_many :responses, as: :user_input
end
