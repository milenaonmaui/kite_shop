class KiteShop::Kite 
   attr_accessor :name, :price, :url, :details, :size, :colors
   @@all = {}
   # TO DO: @@ all needs to be link a hash by size
   # see student roster by grade
   def initialize(attr_hash)
    @size = attr_hash[:size]
    @name = attr_hash[:name]
    @price = attr_hash[:price]
    @url = "https://www.realwatersports.com" + attr_hash[:link]
    #binding.pry
    @@all[@size]||=@@all[@size]=[]
    @@all[@size] << self
   end

   def self.all(size)
    @@all[size]
   end

   def print_colors
    if @colors != []
        puts "Colors:"
        @colors.each {|color| puts "     #{color}"}
    end
    end
end