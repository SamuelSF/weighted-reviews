class ProductsController < ApplicationController
    def index
        @products = Product.order("title ASC").paginate(:page => params[:page], :per_page => 20)
        render 'index'
    end

    def show
        @product = Product.find(params[:id])
        @reviews = @product.reviews.paginate(:page => params[:page], :per_page => 20)
    end
end