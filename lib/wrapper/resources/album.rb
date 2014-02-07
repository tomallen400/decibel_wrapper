class Decibel::Album
	
	attr_accessor :Title, :FeaturedArtistString, :IsUnofficial, :Identifiers, :Genres
	
	def initialize args
		args.each do |k, v|
  		instance_variable_set("@#{k}", v) unless v.nil?
  	end
  	#self.child_initializers
	end
	
	def child_initializers
		self.identifiers_initialize if self.Identifiers
	end
	
	def identifiers_initialize
		array = []
		self.Identifiers.each do |i|
			array << Decibel::Identifier.new(i)
		end
		self.Identifiers = array
	end
	
	def genres_initialize
		array = []
		self.Genres.each do |i|
			array << Decibel::Genre.new(i)
		end
		self.Genres = array
	end

end