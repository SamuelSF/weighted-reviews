class ReviewValidator < ActiveModel::Validator
    def validate(review)
        unless Review.find_by(user_id: review.user_id, product_id: review.product_id) == nil or not review.new_record?
            review.errors[:user_id] << "You cannot review a product more than once."
        end
    end
end

class Review < ActiveRecord::Base
    belongs_to :product
    belongs_to :user
    has_many :user_ratings
    include ActiveModel::Validations
    validates_with ReviewValidator
    validates :title, presence: true
    validates :review_score, presence: true
    validates :body, presence: true

    def compute_review_weight
        ratings = self.user_ratings.select(:rating_score)
        if ratings.length > 0
            average_rating = (ratings.reduce(0) { |sum, rating|
                sum + rating.rating_score }) / ratings.length

            new_weight = average_rating * (Math.log(ratings.length) + 1)
            self.update(weight: new_weight)
        else
            self.update(weight: 5.0)
        end
    end

    def new_review_sequence
        self.user.tally_reviews
        self.product.tally_reviews
        self.user.compute_user_weight
        self.user.products.each do |product|
            product.compute_product_score
        end
    end

    def tally_ratings
        self.update(rating_num: self.user_ratings.length)
    end

    def delete_review_sequence
        reviewed_product = self.product
        reviewer = self.user
        user_ratings = self.user_ratings
        user_ratings.destroy_all
        self.destroy
        puts "I done dit it now!"
        reviewed_product = Product.find(reviewed_product.id)
        reviewer = User.find(reviewer.id)
        reviewer.tally_reviews
        reviewer.compute_user_weight
        reviewed_product.tally_reviews
        reviewed_product.compute_product_score
        reviewer.products.each do |product|
            product.compute_product_score
        end
    end
end
