class ReviewsController < ApplicationController

    before_action :authenticate_user!, only: [ "new", "create" ]
    def new
        @product = Product.find(params[:product_id])
        render 'new'
    end

    def create
        product = Product.find(params[:product_id])
        review = product.reviews.new(review_params)
        review.user = current_user
        if review.save
            review.new_review_sequence
        end
        redirect_to "/products/#{params[:product_id]}"
    end

    def show
        @review = Review.find(params[:id])
        render 'show'
    end

    private

    def review_params
        params.require(:review).permit(:title, :body, :review_score)
    end
end
