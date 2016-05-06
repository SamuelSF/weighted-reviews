class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    has_many :reviews
    has_many :user_ratings
    has_many :products, through: :reviews

    def compute_user_weight
        reviews = self.reviews.select(:weight)
        new_weight = 1.0
        if reviews.length > 0
            average_review_weight = (reviews.reduce(0){|sum, review|
                sum + review.weight
                }) / reviews.length

            new_weight = average_review_weight * (Math.log(reviews.length) + 1)
            self.update(weight: new_weight)
        end
    end
end
