class Product < ActiveRecord::Base
    has_many :reviews
    has_many :users, through: :reviews

    def compute_product_score
        puts "Computing score for #{self.title}"
        reviews = self.reviews
        if reviews.length > 0
            sum_of_user_weights = 0
            review_sum = reviews.reduce(0) do |sum, review|
                user_weight = review.user.weight
                sum_of_user_weights += user_weight
                sum + (review.review_score * user_weight)
            end
            new_product_score = review_sum / sum_of_user_weights
            self.update(product_score: new_product_score)
        end
    end

    def tally_reviews
        num = self.reviews.length
        self.update(review_num: num)
    end
end