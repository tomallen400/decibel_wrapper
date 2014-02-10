require 'spec_helper'

describe Decibel::Work do

	let(:wrapper) { Decibel::Wrapper.new(:decibel_app_id => 'fb8f43a3', :decibel_app_key => 'b77c9a355af301c4d1aefe7273ba6fec')  }
	let(:decibel_work) { wrapper.work(:id => '5e9c115c-7e00-11e3-be7b-ac220b82800d') }
	let(:work) { Decibel::Work.new(:Id => '5e9c115c-7e00-11e3-be7b-ac220b82800d', :Title => "Zephyr Song", :Participations => [{:LiteralMainIdentities => "John Frusciante", :MainIdentities => [{:Id => "03d85421-463a-e311-be6d-ac220b82800d", :LiteralName => "John Frusciante"}], :LiteralActivity => "Written-By", :Activities => [{:Name => "Written By"}]}]) }
	let(:blank_work) { Decibel::Recording.new(:Id => "") }
	subject { work }
	
	it { should respond_to(:Id) }
	it { should respond_to(:Title) }
	it { should respond_to(:Participations) }
	it { should respond_to(:Tracks) }
	
	it "should set Participations to an array" do
		work.Participations.should be_an_instance_of Array
	end
	it "should set Participations to an array of Decibel::Participations" do
		work.Participations[0].should be_an_instance_of Decibel::Participation
	end
	it "should set Participations to nil if no Participations" do
		blank_work.Participations.should be_nil
	end
	
	
end