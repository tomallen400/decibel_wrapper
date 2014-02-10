require 'spec_helper'

describe Decibel::Recording do

	let(:wrapper) { Decibel::Wrapper.new(:decibel_app_id => 'fb8f43a3', :decibel_app_key => 'b77c9a355af301c4d1aefe7273ba6fec')  }
	let(:decibal_recording) { wrapper.recording(:id => '5e9c115a-7e00-11e3-be7b-ac220b82800d') }
	let(:recording) { Decibel::Recording.new(:Id => '5e9c115a-7e00-11e3-be7b-ac220b82800d', :Title => "Zephyr Song", :Genres => [{:Name => "House"}, {:Name => "Electro"}], :Duration => 232.0, :FeaturedArtists => [{:Id => "efcd42f6-7dff-11e3-be7b-ac220b82800d", :LiteralName => "Red Hot Chili Peppers"}], :Participations => [{:LiteralMainIdentities => "Chad Smith", :MainIdentities => [{:Id  => "f8d2a321-463a-e311-be6d-ac220b82800d", :LiteralName => "Chad Smith"}], :LiteralActivity => "Drums", :Activities => [{:Name => "Drums"}]}], :Authors => [{:LiteralMainIdentities => "John Frusciante", :MainIdentities => [{:Id => "03d85421-463a-e311-be6d-ac220b82800d", :LiteralName => "John Frusciante"}], :LiteralActivity => "Written-By", :Activities => [{:Name => "Written By"}]}]) }
	let(:blank_recording) { Decibel::Recording.new(:Id => "") }
	subject { recording }
	
	it { should respond_to(:Id) }
	it { should respond_to(:Title) }
	it { should respond_to(:FeaturedArtistString) }
	it { should respond_to(:Duration) }
	it { should respond_to(:FeaturedArtists) }
	
	it "should set FeaturedArtists to an array" do
		recording.FeaturedArtists.should be_an_instance_of Array
	end
	it "should set FeaturedArtists to an array of Decibel::FeaturedArtists" do
		recording.FeaturedArtists[0].should be_an_instance_of Decibel::FeaturedArtist
	end
	it "should set FeaturedArtists to nil if no FeaturedArtists" do
		blank_recording.FeaturedArtists.should be_nil
	end
	it "should set Genres to an array" do
		recording.Genres.should be_an_instance_of Array
	end
	it "should set Genres to an array of Decibel::Genre" do
		recording.Genres[0].should be_an_instance_of Decibel::Genre
	end
	it "should set Genres to nil if no Genres" do
		blank_recording.Genres.should be_nil
	end
	it "should set Participations to an array" do
		recording.Participations.should be_an_instance_of Array
	end
	it "should set Participations to an array of Decibel::RecordingParticipations" do
		recording.Participations[0].should be_an_instance_of Decibel::Participation
	end
	it "should set Participations to nil if no Participations" do
		blank_recording.Participations.should be_nil
	end
	it "should set Authors to an array" do
		recording.Authors.should be_an_instance_of Array
	end
	it "should set Authors to an array of Decibel::RecordingParticipations" do
		recording.Authors[0].should be_an_instance_of Decibel::Participation
	end
	it "should set Authors to nil if no Authors" do
		blank_recording.Authors.should be_nil
	end
	
end