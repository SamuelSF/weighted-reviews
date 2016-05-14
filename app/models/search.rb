class Search
    def initialize
        @key = "api_key=#{ENV['giantbomb_api_key']}"
        @base_uri = "http://giantbomb.com/api/search?"
        @format = "&format=json"
        @resources = "&resources=game"
        @field_list = "&field_list=name,platforms,original_release_date,image,deck,id"
        @limit = "&limit=4"
    end

    def fetch(query)
        query.gsub!(" ", "+")
        query_term = "&query=" + query
        query_uri = @base_uri + @key + query_term + @format + @resources + @field_list + @limit
        HTTParty.get(query_uri, headers: {"User-Agent" => "YouRateIt.herokuApp.com"}).parsed_response
    end

    def maker(query)
        products = []
        search = self.fetch(query)
        search["results"].each do |result|
            if Product.find_by(api_id: result["id"])
                products << Product.find_by(api_id: result["id"])
            else
                products << self.producer(result)
            end
        end
        products
    end

    def parse_platforms(p_array)
        p_string = ""
        p_array.each do |platform|
            p_string << (platform["name"] + ",")
        end
        p_string
    end

    def producer(result)
        product = Product.new
        product.title = result["name"]
        product.description = result["deck"]
        product.api_id = result["id"]
        product.platforms = self.parse_platforms(result["platforms"])
        product.thumb_img = result["image"]["thumb_url"]
        product.med_img = result["image"]["medium_url"]
        product.original_release_date = result["original_release_date"]
        product
    end
end