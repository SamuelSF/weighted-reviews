class UserRatingsController < ApplicationController

    before_action :authenticate_user!, only: ["new", "create"]

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

    private
        def user_rating_params
            params.require(:user_rating).permit(:body, :rating_score)
        end
end
