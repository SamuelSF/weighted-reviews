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
    end

    def reviews
    end
end
