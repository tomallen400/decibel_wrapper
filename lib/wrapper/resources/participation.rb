class Decibel::Participation
	
	attr_accessor :LiteralMainIdentities, :MainIdentities, :LiteralActivity, :Activities, :LiteralArtists, :Artists
	
	def initialize args
		args.each do |k, v|
  		instance_variable_set("@#{k}", v) unless v.nil?
  	end
  	self.child_initializers
	end
	
	def child_initializers
		self.main_identities_initialize if self.MainIdentities
		self.artists_initialize if self.Artists
		self.activities_initialize if self.Activities
	end
	
	def main_identities_initialize
		array = []
		self.MainIdentities.each do |i|
			array << Decibel::MainIdentity.new(i)
		end
		self.MainIdentities = array
	end
	
	def activities_initialize
		array = []
		self.Activities.each do |a|
			array << Decibel::Activity.new(a)
		end
		self.Activities = array
	end
	
	def artists_initialize
		array = []
		self.Artists.each do |a|
			array << Decibel::Artist.new(a)
		end
		self.Artists = array
	end
	
end