class UserRatingsController < ApplicationController


    before_action :authenticate_user!, only: ["new", "create"]

    # route is POST -> /reviews/:id/user_rating/
    def create
        review = Review.find(params[:id])
        new_user_rating = review.user_ratings.new(user_rating_params)
        new_user_rating.user = current_user
        if new_user_rating.save
            new_user_rating.new_rating_sequence
        else
            #bad stuff here
        end
    end

    def new
        render plain: "Rating for review id #{params[:id]}"
    end

    private
        def user_rating_params
            params.require(:user_rating).permit(:rating_score)
        end
end
