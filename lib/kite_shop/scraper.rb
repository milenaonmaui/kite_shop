class KiteShop::Scraper 
    
    def get_page
        Nokogiri::HTML(open("https://www.realwatersports.com/collections/kites/size_9m"))
    end
    
      def scrape_products
        #returns an array of products
        #name - arr[0].css(".productitem--title a").text.strip
        #price - arr[0].css(".price--main").text.strip 
        #arr[0].css("a").attribute("href").value
         self.get_page.css(".productgrid--item-kite .productitem--info")
         
      end
end