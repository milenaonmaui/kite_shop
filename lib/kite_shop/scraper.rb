class KiteShop::Scraper 
    
    def get_page(url)
        Nokogiri::HTML(open(url))
    end
    
      def scrape_products(url)
        #returns an array of products
        #name - arr[0].css(".productitem--title a").text.strip
        #price - arr[0].css(".price--main").text.strip 
        #arr[0].css("a").attribute("href").value
         self.get_page(url).css(".productgrid--item-kite .productitem--info")
         
      end
end