class Decibel::Participation
	
	attr_accessor :LiteralMainIdentities, :MainIdentities, :LiteralActivity, :Activities
	
	def initialize args
		args.each do |k, v|
  		instance_variable_set("@#{k}", v) unless v.nil?
  	end
  	self.child_initializers
	end
	
	def child_initializers
		self.main_identities_initialize
		self.activities_initialize
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
	
end