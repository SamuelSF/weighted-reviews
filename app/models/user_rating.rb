class UserRatingValidator < ActiveModel::Validator
    def validate(user_rating)
        unless UserRating.find_by(user_id: user_rating.user_id, review_id: user_rating.review_id) == nil or not user_rating.new_record?
            user_rating.errors[:user_id] << "You cannot rate a review more than once! No CSRF for you!"
        end
        if user_rating.user_id == user_rating.review.user_id
            user_rating.errors[:user_id] << "You cannot rate your own review! No CSRF for you!"
        end
    end
end

class UserRating < ActiveRecord::Base
    belongs_to :user
    belongs_to :review
    include ActiveModel::Validations
    validates_with UserRatingValidator
    validates :body, presence: true
    validates :rating_score, presence: true

    def new_rating_sequence
        self.review.tally_ratings
        self.review.compute_review_weight
        self.review.user.compute_user_weight
        self.review.user.products.each do |product|
            product.compute_product_score
        end
    end

    def delete_rating_sequence
        review = self.review
        user = review.user
        self.destroy
        review = Review.find(review.id)
        user = User.find(user.id)
        review.tally_ratings
        review.compute_review_weight
        user.compute_user_weight
        user.products.each do |product|
            product.compute_product_score
        end
    end
end