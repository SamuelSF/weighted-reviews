class ReviewsController < ApplicationController

    before_action :authenticate_user!, only: [ "new", "create", "edit", "update", "delete" ]
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

    def edit
        @review = Review.find(params[:id])
        render 'edit'
    end

    def update
        @review = Review.find(params[:id])
        unless current_user.id != @review.user_id
            @review.update(review_params)
            @review.new_review_sequence
        end
        redirect_to "/reviews/<%= @review.id %>"
    end

    def delete
        @review = Review.find(params[:id])
        unless @review.user_id != current_user.id
            @review.delete_review_sequence
        end
        redirect_to "/products/#{@review.product_id}"
    end

    private

    def review_params
        params.require(:review).permit(:title, :body, :review_score)
    end
end