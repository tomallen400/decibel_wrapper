class Decibel::Participant
	
	attr_accessor :Id, :Name, :StageName, :Identifiers, :Biography, :BiographySnippet, :Members
	
	def initialize args
		args.each do |k, v|
  		instance_variable_set("@#{k}", v) unless v.nil?
  	end
  	self.members_initialize if self.Members
	end
	
	def members_initialize
		array = []
		self.Members.each do |m|
			array << Decibel::Participant.new(m)
		end
		self.Members = array
	end
	
end