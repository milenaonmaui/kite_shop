class KiteShop::CLI 
    def start 
      base_url = "https://www.realwatersports.com/collections/kites/"
 
      puts "Select a kite size you are interested in:"
      puts "Enter 3, 5, 9, or 11"
      size = gets.strip
      url = base_url + "size_"+size+"m"
      #puts url
    end


end