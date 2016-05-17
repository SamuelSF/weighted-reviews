class ProductsController < ApplicationController
    def index
        @products = Product.order("title ASC")
        render 'index'
    end

    def show
        @product = Product.find(params[:id])
        @reviews = @product.reviews

    end
end