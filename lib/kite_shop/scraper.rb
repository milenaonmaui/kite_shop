class KiteShop::Scraper 
    attr_reader :url
    def initialize(url)
        @url = url
    end

    def get_page
        Nokogiri::HTML(open(@url))
    end
    
    def scrape_products
        #returns an array of products
        #name - arr[0].css(".productitem--title a").text.strip
        #price - arr[0].css(".price--main").text.strip 
        #arr[0].css("a").attribute("href").value
        prod_array = self.get_page.css(".productgrid--item-kite .productitem--info")
    
        prod_array.each do |product_card|
          attributes = {
          :name => product_card.css(".productitem--title a").text.strip,
          :price => product_card.css(".price--main").text.strip,
          :link => product_card.css("a").attribute("href").value
          }
          #binding.pry
        kite = KiteShop::Kite.new(attributes)
        end
    end

    def scrape_details(kite) 
        #array of lines - 36
        page = self.get_page
        kite.price = page.css("div.price--main span.money").last.text.strip
        details = page.css(".product-description ul li").take(5)
        kite.details = details.collect {|detail| detail.text}
        kite.details
    end

   
end