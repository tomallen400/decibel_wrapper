class Decibel::Participant
	
	attr_accessor :Id, :Name, :StageName, :Identifiers, :Annotations, :Members
	
	def initialize args
		args.each do |k, v|
  		instance_variable_set("@#{k}", v) unless v.nil?
  	end
  	self.child_initializers
	end
	
	def child_initializers
		self.members_initialize if self.Members
  	self.annotations_initialize if self.Annotations
	end
	
	def members_initialize
		array = []
		self.Members.each do |m|
			array << Decibel::Participant.new(m)
		end
		self.Members = array
	end
	
	def annotations_initialize
		array = []
		self.Annotations.each do |m|
			array << m[:Text]
		end
		self.Annotations = array
	end
	
end