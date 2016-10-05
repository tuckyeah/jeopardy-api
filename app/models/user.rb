class User < ActiveRecord::Base
  include Authentication
  has_many :examples
  has_many :games
  has_many :responses, as: :user_input

    def admin?(params)
      params[:email] == 'admin@admin'
    end
end
