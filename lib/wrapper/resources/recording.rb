class Decibel::Recording
	
	attr_accessor :Id, :AlbumSequence, :Title, :Artists, :FeaturedArtistString, :Duration, :FeaturedArtists, :Genres, :Participations, :Authors
	
	def initialize args
		args.each do |k, v|
  		instance_variable_set("@#{k}", v) unless v.nil?
  	end
  	self.child_initializers
	end
	
	def child_initializers
		self.featured_artists_initialize if self.FeaturedArtists
		self.genres_initialize if self.Genres
		self.participations_initialize if self.Participations
		self.authors_initialize if self.Authors
		self.artists_initialize if self.Artists
	end
	
	def featured_artists_initialize
		array = []
		self.FeaturedArtists.each do |a|
			array << Decibel::FeaturedArtist.new(a)
		end
		self.FeaturedArtists = array
	end
	
	def genres_initialize
		array = []
		self.Genres.each do |i|
			array << Decibel::Genre.new(i)
		end
		self.Genres = array
	end
	
	def participations_initialize
		array = []
		self.Participations.each do |p|
			array << Decibel::Participation.new(p)
		end
		self.Participations = array
	end
	
	def authors_initialize
		array = []
		self.Authors.each do |a|
			array << Decibel::Participation.new(a)
		end
		self.Authors = array
	end
	
	def artists_initialize
		array = []
		self.Artists.each do |a|
			array << Decibel::Artist.new(a)
		end
		self.Artists = array
	end
	
	# Needs looking at for refactoring
	def child_initializer(object, child_object)
		array = []
		object.each do |o|
			array << child_object.new(o)
		end
		object = array
	end
	
end