class SearchesController < ApplicationController
    def main
        if params[:query]
            @results = Search.new.fetch(params[:query])
        end
        render 'main'
    end
end
