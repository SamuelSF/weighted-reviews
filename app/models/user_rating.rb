class UserRating < ActiveRecord::Base
    belongs_to :user
    belongs_to :review

    def new_rating_sequence
        self.review.compute_review_weight
        self.review.user.compute_user_weight
        self.review.user.products.each do |product|
            product.compute_product_score
        end
    end
end