class ProductsController < ApplicationController
    def index
        @products = Product.all
        render 'index'
    end

    def show
        @product = Product.find(params[:id])
        @reviews = @product.reviews
        render 'show'
    end
end