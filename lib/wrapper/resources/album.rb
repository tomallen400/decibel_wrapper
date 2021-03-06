class Decibel::Album
	
	attr_accessor :Id, :Title, :FeaturedArtistString, :ArtistsLiteral, :FeaturedArtists, :IsUnofficial, :Identifiers, :Genres, :Recordings, :Artists, :Participations, :OriginalReleaseDate, :ImageId, :ImageUrl, :ThumbnailUrl
	
	def initialize args
		args.each do |k, v|
  		instance_variable_set("@#{k}", v) unless v.nil?
  	end
  	self.child_initializers
	end
	
	def child_initializers
		self.identifiers_initialize if self.Identifiers
		self.featured_artists_initialize if self.FeaturedArtists
		self.genres_initialize if self.Genres
		self.recordings_initialize if self.Recordings
		self.artists_initialize if self.Artists
	end
	
	def identifiers_initialize
		array = []
		self.Identifiers.each do |i|
			array << Decibel::Identifier.new(i)
		end
		self.Identifiers = array
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
	
	def recordings_initialize
		array = []
		self.Recordings.each do |i|
			array << Decibel::Recording.new(i)
		end
		self.Recordings = array
	end
	
	def artists_initialize
		array = []
		self.Artists.each do |i|
			array << Decibel::Artist.new(i)
		end
		self.Artists = array
	end
	
	def participations_initialize
		array = []
		self.Participations.each do |i|
			array << Decibel::Participation.new(i)
		end
		self.Participations = array
	end

end