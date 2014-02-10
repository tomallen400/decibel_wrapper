class Decibel::FeaturedArtist
	
	attr_accessor :Id, :Name
	
	def initialize args
		args.each do |k, v|
  		instance_variable_set("@#{k}", v) unless v.nil?
  	end
	end
	
end