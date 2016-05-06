class Review < ActiveRecord::Base
    belongs_to :product
    belongs_to :user
    has_many :user_ratings

    def compute_review_weight
        ratings = self.user_ratings.select(:rating_score)
        if ratings.length > 0
            sum_of_ratings = ratings.reduce(0) do |sum, rating|
                sum + rating.rating_score
            end
            new_weight = sum_of_ratings / ratings.length
            self.update(weight: new_weight)
        end
    end
end