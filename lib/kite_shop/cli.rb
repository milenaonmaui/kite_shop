class KiteShop::CLI 
    def start 
      base_url = "https://www.realwatersports.com/collections/kites/"
      puts "Welcome to the Kite Shopping app!"
      puts "Select a kite size (in m) you are interested in:"
      puts "Enter 3, 5, 7, 9, or 11"
      puts "Enter q to quit"
      size = nil
      until ["3","5","7","9", "11", "q"].include?(size)
        puts "Select 3, 5, 7, 9 or 11 or q to quit"
        size = gets.strip
      end
      if size != "q"
        url = base_url + "size_"+size+"m"
        #puts url
        #call scraper class with url
        scraper = KiteShop::Scraper.new(url)
        #scraper class will generate new kite class
        scraper.scrape_products
        list_kites
        list_details
        continue
      else
        puts "Goodbye!"
      end
    end

    def list_kites
      KiteShop::Kite.all.each.with_index(1) do |kite, index|
         puts "#{index}. #{kite.name}.  Price range: #{kite.price}"
      end
    end

    def list_details
     
      puts "Select a product number to view details."
      puts "Select q to go to the main menu"
      input = gets.strip
      if input.upcase == "Q"
        start
      elsif input.to_i.between?(1,KiteShop::Kite.all.size)
        selected_kite = KiteShop::Kite.all[input.to_i-1]      
        puts "You selected #{selected_kite.name}"
        scraper = KiteShop::Scraper.new(selected_kite.url)
         # if kite details have not been scraped, scrape
        selected_kite.details ||= scraper.scrape_details(selected_kite)
        puts "Price: #{selected_kite.price}"
        puts "URL: #{selected_kite.url}"
        if selected_kite.details
          puts "Details: "
          selected_kite.details.each {|detail| puts "    "+detail}       
        end
      else
        puts "Ivalid number"
        list_details
      end
    end

    def continue
      puts "Would you like to view another product? (Y/N)"
      input = gets.strip
      if input.upcase == "Y"
        list_kites
        list_details
        continue
      end
    end  

end