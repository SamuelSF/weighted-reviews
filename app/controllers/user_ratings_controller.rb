class UserRatingsController < ApplicationController

    before_action :authenticate_user!, only: ["new", "create", "edit", "update", "delete"]

    # route is POST -> /reviews/:id/user_ratings
    def create
        review = Review.find(params[:review_id])
        new_user_rating = review.user_ratings.new(user_rating_params)
        new_user_rating.user = current_user
        if new_user_rating.save
            new_user_rating.new_rating_sequence
        else

        end
        redirect_to "/reviews/#{review.id}"
    end

    def new
        @review = Review.find(params[:review_id])
        render 'new'
    end

    def edit
        @user_rating = UserRating.find(params[:id])
        render 'edit'
    end

    def update
        @user_rating = UserRating.find(params[:id])
        unless current_user.id != @user_rating.user_id
            @user_rating.update(user_rating_params)
            @user_rating.new_rating_sequence
        end
        redirect_to "/reviews/#{@user_rating.review_id}"
    end

    def delete
        @user_rating = UserRating.find(params[:id])
        unless current_user.id != @user_rating.user_id
            @user_rating.delete_rating_sequence
        end
        redirect_to "/reviews/#{@user_rating.review_id}"
    end
    private
        def user_rating_params
            params.require(:user_rating).permit(:body, :rating_score)
        end
end
