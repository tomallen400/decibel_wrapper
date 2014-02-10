class Decibel::Work
	
	attr_accessor :Id, :Title, :Participations, :Tracks
	
	def initialize args
		args.each do |k, v|
  		instance_variable_set("@#{k}", v) unless v.nil?
  	end
  	self.participations_initialize if self.Participations
	end
	
	def participations_initialize
		array = []
		self.Participations.each do |p|
			array << Decibel::Participation.new(p)
		end
		self.Participations = array
	end
	
end