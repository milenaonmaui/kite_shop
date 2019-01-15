class KiteShop::CLI 
    attr_accessor :size
    def start 
      base_url = "https://www.realwatersports.com/collections/kites/"
      puts "Welcome to the Kite Shopping app!"
      puts "\nSelect a kite size (in m) you are interested in:"
      @size = nil
      until ["3","5","7","9", "11", "q"].include?(size)
        puts "Select 3, 5, 7, 9 or 11 or q to quit"
        @size = gets.strip
      end
      if @size == "q"
        exit
      end
        #scrape only ifsize not scraped yet
      if KiteShop::Kite.all(@size) == nil        
        url = base_url + "size_"+@size+"m"
        scraper = KiteShop::Scraper.new(url)
        scraper.scrape_products
      end
      list_kites
        
      puts "\nSelect a product number from the list to view more information on."
      puts "Type exit to go to the main menu"
      input = gets.strip
      
      if input == "exit"
        start
      elsif input.to_i.between?(1,KiteShop::Kite.all(@size).length)
        selected_kite = KiteShop::Kite.all(@size)[input.to_i-1] 
        list_details(selected_kite)
      else
        puts "\nInvalid product number!"
      end

      puts "\nWould you like to view another product? (Y/N)"

      input = gets.strip.downcase
      if input == "y"
        start
      elsif input == "n"
        puts "\nGoodbye!"
        exit
      else

        puts "\nInvalid answer. Try again."
        start
      end
    end #end of start

    def list_kites
      puts "All kites of size #{@size}m:"
      puts "-------------------------------------------"
      KiteShop::Kite.all(@size).each.with_index(1) do |kite, index|
         puts "#{index}. #{kite.name}.  Price range: #{kite.price}"
      end
      puts "-------------------------------------------"
    end

    def list_details(selected_kite)
        puts "-------------------------------------------"
        puts "You selected #{selected_kite.name} -- #{selected_kite.size} meters"
        scraper = KiteShop::Scraper.new(selected_kite.url)
         # if kite details have not been scraped, scrape
        selected_kite.details ||= scraper.scrape_details(selected_kite)
        puts "Price:"
        puts "     #{selected_kite.price}"
        if selected_kite.details !=[]
          puts "Details: "
          selected_kite.details.each {|detail| puts "     "+detail}       
        end
        selected_kite.print_colors
        puts "URL:"
        puts "     #{selected_kite.url}"
    end

end