class KiteShop::CLI 
    def start 
      base_url = "https://www.realwatersports.com/collections/kites/"
      puts "Welcome to the Kite Shopping app!"
      puts "Select a kite size you are interested in:"
      puts "Enter 3, 5, 9, or 11"
      size = gets.strip
      url = base_url + "size_"+size+"m"
      #puts url
      #call scraper class with url
      scraper = KiteShop::Scraper.new(url)
      scraper.scrape_products
      #binding.pry
      #scraper class will generate new kite class
    
    end

    def list_kites
      KiteShop::Kite.all.each.with_index(1) do |kite, index|
         puts "#{index}. #{kite.name}.  Price range: #{kite.price}"
      end
    end

    def list_details
      # if kte details have not been scraped, scrape
    end

end