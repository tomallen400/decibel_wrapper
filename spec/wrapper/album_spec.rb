require 'spec_helper'

describe Decibel::Album do

	let(:wrapper) { $wrapper }
	let(:decibal_album) { wrapper.album(:id => 'cd94ce57-533a-e311-be6d-ac220b82800d') }
	let(:album) { Decibel::Album.new(:Id => 'cd94ce57-533a-e311-be6d-ac220b82800d', :Identifiers => [{:IdentifierType => "A type", :Value => "1234"}], :Genres => [{:Name => "House"}, {:Name => "Electro"}], :FeaturedArtists => [{:Id => "6e862d4e-8476-11e3-be7e-ac220b82800d", :LiteralName => "The Rolling Stones" }, {:Id => "6e862d4e-8476-11e3-be7e-ac220b82800d", :LiteralName => "The Rolling Stones" }], :Tracks => [{:Id => "6e862d28-8476-11e3-be7e-ac220b82800d", :Title => "Brown Sugar"}, {:Id => "6e862d50-8476-11e3-be7e-ac220b82800d", :Title => "Sway"}]) }
	subject { album }
	
	it { should respond_to(:Id) }
	it { should respond_to(:Title) }
	it { should respond_to(:FeaturedArtistString) }
	it { should respond_to(:FeaturedArtists) }
	it { should respond_to(:IsUnofficial) }
	it { should respond_to(:Identifiers) }
	it { should respond_to(:Genres) }
	it { should respond_to(:Tracks) }
	
	
	it "should set initializers to an array" do
		album.Identifiers.should be_an_instance_of Array
	end
	it "should set initializers to an array of Decibel::Identifier s" do
		album.Identifiers[0].should be_an_instance_of Decibel::Identifier
	end
	it "should set featured artists to an array" do
		album.FeaturedArtists.should be_an_instance_of Array
	end
	it "should set featured artists to an array of Decibel::FeaturedArtists" do
		album.FeaturedArtists[0].should be_an_instance_of Decibel::FeaturedArtist
	end
	it "should set genres to an array" do
		album.Genres.should be_an_instance_of Array
	end
	it "should set genres to an array of Decibel::Genres" do
		album.Genres[0].should be_an_instance_of Decibel::Genre
	end
	it "should set tracks to an array" do
		album.Tracks.should be_an_instance_of Array
	end
	it "should set tracks to an array of Decibel::Recordings" do
		album.Tracks[0].should be_an_instance_of Decibel::Recording
	end
		

end