require 'spec_helper'

describe Decibel::Album do

	let(:wrapper) { Decibel::Wrapper.new(:decibel_app_id => 'fb8f43a3', :decibel_app_key => 'b77c9a355af301c4d1aefe7273ba6fec')  }
	let(:decibal_album) { wrapper.album(:id => 'cd94ce57-533a-e311-be6d-ac220b82800d') }
	let(:album) { Decibel::Album.new(:Id => 'cd94ce57-533a-e311-be6d-ac220b82800d', :Identifiers => [{:IdentifierType => "A type", :Value => "1234"}], :Genres => [{:Name => "House"}, {:Name => "Electro"}]) }
	subject { album }
	
	it { should respond_to(:Title) }
	it { should respond_to(:FeaturedArtistString) }
	it { should respond_to(:IsUnofficial) }
	it { should respond_to(:Identifiers) }
	
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

end