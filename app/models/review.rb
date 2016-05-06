class Review < ActiveRecord::Base
    belongs_to :product
    belongs_to :user
    has_many :user_ratings
end
