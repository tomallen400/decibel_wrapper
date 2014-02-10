require 'spec_helper'

describe Decibel::Participant do

	let(:wrapper) { Decibel::Wrapper.new(:decibel_app_id => 'YOUR_DECIBEL_APP_ID', :decibel_app_key => 'YOUR_DECIBEL_APP_KEY')  }
	let(:decibal_participant) { wrapper.participant(:id => '5e9c115a-7e00-11e3-be7b-ac220b82800d') }
	let(:participant) { Decibel::Participant.new(:Id => "1fe03321-463a-e311-be6d-ac220b82800d", :Name => "The Rolling Stones", :StageName => "The Rolling Stones", :Members => [:Id => "1fe03321-463a-e311-be6d-ac220b82800d", :Name => "The Rolling Stones", :StageName => "The Rolling Stones", :Identifiers => [{:IdentifierType => "DiscogsName", :Value => "Rolling Stones, The"}, {:IdentifierType => "DiscogsID", :Value => "a20991"}]], :Identifiers => [{:IdentifierType => "DiscogsName", :Value => "Rolling Stones, The"}, {:IdentifierType => "DiscogsID", :Value => "a20991"}], :ParticipantType => 1) }
	subject { participant }
	
	it { should respond_to(:Id) }
	it { should respond_to(:Name) }
	it { should respond_to(:StageName) }
	it { should respond_to(:Identifiers) }
	it { should respond_to(:Biography) }
	it { should respond_to(:BiographySnippet) }
	it { should respond_to(:Members) }

	it "should set Members to an array" do
		participant.Members.should be_an_instance_of Array
	end
	it "should set Members to an array of Decibel::Participants" do
		participant.Members[0].should be_an_instance_of Decibel::Participant
	end
	
end