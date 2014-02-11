require 'spec_helper'

describe Decibel::Album do

	let(:wrapper) { Decibel::Wrapper.new(:decibel_app_id => 'YOUR_DECIBEL_APP_ID', :decibel_app_key => 'YOUR_DECIBEL_APP_KEY')  }
	let(:decibal_album) { wrapper.album(:id => 'cd94ce57-533a-e311-be6d-ac220b82800d') }
	let(:album) { Decibel::Album.new(:Id => 'cd94ce57-533a-e311-be6d-ac220b82800d', :Identifiers => [{:IdentifierType => "A type", :Value => "1234"}], :Genres => [{:Name => "House"}, {:Name => "Electro"}]) }
	subject { album }
	
	it { should respond_to(:Title) }
	it { should respond_to(:FeaturedArtistString) }
	it { should respond_to(:IsUnofficial) }
	it { should respond_to(:Identifiers) }
	it { should respond_to(:Genres) }
	it { should respond_to(:Tracks) }
	
	describe "identifiers_initialize" do
		before { album.identifiers_initialize }
		it "should set initializers to an array" do
			album.Identifiers.should be_an_instance_of Array
		end
		it "should set initializers to an array of Decibel::Identifier s" do
			album.Identifiers[0].should be_an_instance_of Decibel::Identifier
		end
	end
	
	describe "genres_intialize" do
		before { album.genres_initialize }
		it "should set genres to an array" do
			album.Genres.should be_an_instance_of Array
		end
		it "should set genres to an array of Decibel::Genre s" do
			album.Genres[0].should be_an_instance_of Decibel::Genre
		end
	end
	
	describe "tracks_initialize" do
		
	end

end