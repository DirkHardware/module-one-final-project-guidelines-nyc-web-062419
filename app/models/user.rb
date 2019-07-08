class User < ActiveRecord::Base

    has_many :assignments
    has_many :chores, through: :assignments

end 