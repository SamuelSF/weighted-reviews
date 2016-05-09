class ReviewsController < ApplicationController
    def new
        @product = Product.find(params[:product_id])
        render 'new'
    end

    def create

    end
end
