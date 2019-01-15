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
        puts "Please wait while generating the list of products..."
        prod_array = self.get_page.css(".productgrid--item-kite .productitem--info")
    
        prod_array.each do |product_card|
          attributes = {
          :name => product_card.css(".productitem--title a").text.strip,
          :price => product_card.css(".price--main").text.strip,
          :link => product_card.css("a").attribute("href").value
          }
          attributes[:size]=@url[@url.length-2]
          kite = KiteShop::Kite.new(attributes)
        end

    end

    def scrape_details(kite) 
        puts "Please wait while generating product information..."
        page = self.get_page
        kite.price = page.css("div.price--main span.money").last.text.strip
        details = page.css(".product-description ul li").take(5)
        kite.details = details.collect {|detail| detail.text}
        colors = page.css(".option-values-color .option-value")
        kite.colors = colors.collect {|color| color.text.strip}        
        kite.details
    end
   
end