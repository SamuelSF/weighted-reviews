class UsersController < ApplicationController
    def index
        @users = User.all.order("username ASC")
        render 'index'
    end

    def show
        @user = User.find(params[:id])
        render 'show'
    end

    def ratings
        @user = User.find(params[:id])
        @ratings = @user.user_ratings.paginate(:page => params[:page], :per_page => 20)
        render 'ratings'
    end

    def reviews
        @user = User.find(params[:id])
        @reviews = @user.reviews.paginate(:page => params[:page], :per_page => 20)
        render 'reviews'
    end
end
