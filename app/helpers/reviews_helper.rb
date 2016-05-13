module ReviewsHelper
    def add_lines(review_string)
        review_string.gsub("\n", "<br>")
    end
end
