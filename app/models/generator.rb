class Generator

    def self.generate_users
        10.times do
            name = Faker::Internet.user_name
            email = Faker::Internet.email(name)
            password = Faker::Internet.password
            password_confirmation = password
            fake_user = User.new
            fake_user.username = name
            fake_user.email = email
            fake_user.password = password
            fake_user.password_confirmation = password_confirmation
            fake_user.save
        end
    end

    def self.generate_reviews
        products = []
        products << Product.find_by(title: "Uncharted 4: A Thief's End")
        products << Product.find_by(title: "Dark Souls III")
        products << Product.find_by(title: "Doom")
        products << Product.find_by(title: "Street Fighter V")
        products << Product.find_by(title: "League of Legends")
        products << Product.find_by(title: "Fallout 4")
        users = User.all
        users.each do |user|
            products.each do |product|
                review = user.reviews.new
                review.product = product
                review.review_score = (Random.rand * 10 + 1).floor
                review.title = Faker::Lorem.sentence(6)
                review.body = Faker::Lorem.paragraph(20)
                review.save
                review.new_review_sequence
            end
        end
    end

    def self.generate_ratings
        reviews = Review.all
        users = User.all
        users.each do |user|
            reviews.each do |review|
                unless user.id == review.user_id
                    user_rating = review.user_ratings.new
                    user_rating.user = user
                    user_rating.rating_score = (Random.rand * 10 + 1).floor
                    user_rating.body = Faker::Lorem.paragraph(5)
                    user_rating.save
                    user_rating.new_rating_sequence
                end
            end
        end
    end

    def self.rebalance
        Review.all.each do |review|
            review.tally_ratings
            review.compute_review_weight
        end
        User.all.each do |user|
            user.tally_reviews
            user.compute_user_weight
        end
        Product.all.each do |product|
            product.tally_reviews
            product.compute_product_score
        end
    end
end