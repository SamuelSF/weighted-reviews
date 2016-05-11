class Review < ActiveRecord::Base
    belongs_to :product
    belongs_to :user
    has_many :user_ratings

    def compute_review_weight
        ratings = self.user_ratings.select(:rating_score)
        if ratings.length > 0
            average_rating = (ratings.reduce(0) { |sum, rating|
                sum + rating.rating_score }) / ratings.length

            new_weight = average_rating * (Math.log(ratings.length) + 1)
            self.update(weight: new_weight)
        end
    end

    def new_review_sequence
        puts self.user.email
        self.user.compute_user_weight
        self.user.products.each do |product|
            puts product.title
            product.compute_product_score
        end
    end
end