class KiteShop::Kite 
   attr_accessor :name, :price, :url
   @@all = []
   # TO DO: @@ all needs to be link a hash by size
   # see student roster by grade
   def initialize(attr_hash)
    @name = attr_hash[:name]
    @price = attr_hash[:price]
    @url = attr_hash[:link]
    @@all << self
   end

   def self.all
    @@all
   end
end