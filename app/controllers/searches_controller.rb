class SearchesController < ApplicationController
    def main
        if params[:query]
            @products = Search.new.maker(params[:query])
        end
        render 'main'
    end
end
