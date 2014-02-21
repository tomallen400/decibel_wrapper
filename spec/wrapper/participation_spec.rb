require 'spec_helper'

describe Decibel::Participation do

	let(:wrapper) { $wrapper }
	let(:participation) { Decibel::Participation.new(:LiteralMainIdentities => "Chad Smith", :MainIdentities => [{:Id => "f8d2a321-463a-e311-be6d-ac220b82800d", :LiteralName => "Chad Smith"}], :LiteralActivity => "Drums", :Activities => [{:Name => "Drums"}]) }
	subject { participation }
	
	it { should respond_to(:LiteralMainIdentities) }
	it { should respond_to(:MainIdentities) }
	it { should respond_to(:LiteralActivity) }
	it { should respond_to(:Activities) }

	it "should set MainIdentities to an array" do
		participation.MainIdentities.should be_an_instance_of Array
	end
	it "should set MainIdentities to an array of Decibel::FeaturedArtist s" do
		participation.MainIdentities[0].should be_an_instance_of Decibel::MainIdentity
	end
	it "should set Activities to an array" do
		participation.Activities.should be_an_instance_of Array
	end
	it "should set Activities to an array of Decibel::Activity s" do
		participation.Activities[0].should be_an_instance_of Decibel::Activity
	end
	it "should set Activities to an array" do
		participation.Artists.should be_an_instance_of Array
	end
	it "should set Activities to an array of Decibel::Activity s" do
		participation.Artists[0].should be_an_instance_of Decibel::Activity
	end
	
end