class SiteController < ApplicationController
    def index
        @products = Product.order("review_num DESC").limit(6)
        render 'index'
    end

    def about
        render 'about'
    end
end
