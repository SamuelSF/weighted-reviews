class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, { presence: true, uniqueness: :true }

    has_many :reviews
    has_many :user_ratings
    has_many :products, through: :reviews

    def compute_user_weight
        reviews = self.reviews.select(:weight)
        if reviews.length > 0
            average_review_weight = (reviews.reduce(0){|sum, review|
                sum + review.weight
                }) / reviews.length

            new_weight = average_review_weight * (Math.log(reviews.length) + 1)
            self.update(weight: new_weight)
        else
          self.update(weight: 5.0)
        end
    end

    def tally_reviews
      num = self.reviews.length
      self.update(review_num: num)
    end

    def delete_user_sequence
      reviewed_products = self.products
      authored_reviews = self.reviews
      user_ratings = self.user_ratings
      user_ratings.each do |user_rating|
        affected_user = user_rating.review.user
        affected_review = user_rating.review
        affected_products = affected_user.products
        user_rating.destroy
        affected_review = Review.find(affected_review.id)
        affected_review.tally_ratings
        affected_review.compute_review_weight
        affected_user = User.find(affected_user.id)
        affected_user.compute_user_weight
        affected_products = affected_products.map {|product| Product.find(product.id)}
        affected_products.each do |affected_product|
          affected_product.compute_product_score
        end
      end
      authored_reviews.each do |authored_review|
        authored_review.user_ratings.destroy_all
        authored_review.destroy
      end
      reviewed_products = reviewed_products.map {|product| Product.find(product.id)}
      reviewed_products.each do |reviewed_product|
        reviewed_product.tally_reviews
        puts "Computing score for #{reviewed_product.title}"
        reviewed_product.compute_product_score
      end
      self.destroy
    end
end
