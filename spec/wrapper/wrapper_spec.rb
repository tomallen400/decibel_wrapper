require 'spec_helper'

describe Decibel::Wrapper do
	
	let(:wrapper) { Decibel::Wrapper.new(:decibel_app_id => 'fb8f43a3', :decibel_app_key => 'b77c9a355af301c4d1aefe7273ba6fec')  }
	let(:test_query) { "albums/?title=the%20fame%20monster&depth=Tracks;TrackAuthors" }
	let(:album_query) { "album/?id=cd94ce57-533a-e311-be6d-ac220b82800d" }
	
	# Album
	describe "album" do
		context "when passed a valid id" do
			it "should return an instance of Decibel::Album" do
				wrapper.album(:id => 'cd94ce57-533a-e311-be6d-ac220b82800d').should be_an_instance_of Decibel::Album
			end
		end
		context "when passed an invalid id" do
			it "should return nil" do
				wrapper.album(:id => 'something_else').should be_nil
			end
		end
	end
	
	describe "albums" do
		context "when finding something" do
			it "should return an array" do
				wrapper.albums(:title => 'the fame monster').should be_an_instance_of Array
			end
			it "should return an array of Decibel::Album" do
				wrapper.albums(:title => 'the fame monster').first.should be_an_instance_of Decibel::Album
			end
		end
		context "when finding nothing" do
			it "should return an empty array" do
				wrapper.albums(:title => 'blank title').should == []
			end
		end
	end
	
	# Create Query String
	describe "create_query_string" do
		it "should return a string" do
			Decibel::Wrapper.create_query_string('albums/?', {:title => "Sticky Fingers"}).should be_an_instance_of String
		end
		it "should add each of the values" do
			Decibel::Wrapper.create_query_string('albums/?', {:title => "Sticky Fingers"}).should == "albums/?title=Sticky%20Fingers"
		end
		it "should separate each key with an &" do
			Decibel::Wrapper.create_query_string('albums/?', {:title => "Sticky Fingers", :mainArtist => "The Rolling Stones"}).should == "albums/?title=Sticky%20Fingers&mainArtist=The%20Rolling%20Stones"
		end
		it "should return first attribute if passed blank hash" do
			Decibel::Wrapper.create_query_string('albums/?', {}).should == "albums/?"
		end
		it "should return first attribute if not passed hash" do
			Decibel::Wrapper.create_query_string('albums/?', nil).should == "albums/?"
		end
	end
	
	describe "hash_to_query_string" do
		it "should return an array" do
			Decibel::Wrapper.hash_to_query_string({:title => "Sticky Fingers"}).should be_an_instance_of Array
		end
		it "should call query_value for each value in hash" do
			Decibel::Wrapper.should_receive(:query_value).exactly(2).times
			Decibel::Wrapper.hash_to_query_string({:title => "Sticky Fingers", :mainArtist => "The Rolling Stones"})
		end
	end
	
	describe "query_value" do
		it "should return a string" do
			Decibel::Wrapper.query_value('title', 'Sticky Fingers').should be_an_instance_of String
		end
		it "should escape string" do
			Decibel::Wrapper.query_value('title', 'Sticky Fingers').should == 'title=Sticky%20Fingers'
		end
		it "should call depth_string if passed the key of depth" do
			Decibel::Wrapper.should_receive(:depth_string)
			Decibel::Wrapper.query_value('depth', {:TrackAuthors => true})
		end
	end
	
	describe "depth_string" do
		it "should return a string" do
			Decibel::Wrapper.depth_string(:Genres => true).should be_an_instance_of String
		end
		it "should join each key where the value is true" do
			Decibel::Wrapper.depth_string(:Genres => true).should == "depth=Genres"
		end
		it "should leave out any keys where the value is false" do
			Decibel::Wrapper.depth_string(:Genres => true, :TrackAuthors => false).should == "depth=Genres"
		end
		it "should join each key with a semi-colon" do
			Decibel::Wrapper.depth_string(:Genres => true, :TrackAuthors => true).should == "depth=Genres;TrackAuthors"
		end
	end
	
	# Hit Decibel API
	describe "send_query" do
		it "should return json as the body" do
			wrapper.send_query('http://rest.decibel.net/v2/' + test_query).body.should be_an_instance_of String
		end
		it "should return a Net::HTTPOK object" do
			wrapper.send_query('http://rest.decibel.net/v2/' + test_query).should be_an_instance_of Net::HTTPOK
		end
	end
	
	describe "query" do
		context "is passed a plural object" do
			it "should return an Array" do
				wrapper.query(test_query).should be_an_instance_of Array
			end
		end
		context "is passed a single object" do
			it "should return a hash" do
				wrapper.query(album_query).should be_an_instance_of Hash
			end
		end
		context "is passed bad data" do
			it "should return nil" do
				wrapper.query('album/?id=c').should be_nil
			end
		end
	end
	
	describe "parse_response" do
		context "is passed a good response" do
			context "for a single object" do
				it "should return a hash" do
					response = wrapper.send_query('http://rest.decibel.net/v2/' + album_query)
					Decibel::Wrapper.parse_response(response).should be_an_instance_of Hash
				end
			end
			context "form multiple objects" do
				it "should return an array" do
					response = wrapper.send_query('http://rest.decibel.net/v2/' + test_query)
					Decibel::Wrapper.parse_response(response).should be_an_instance_of Array
				end
			end
		end
		context "is passed a bad response" do
			it "should return nil" do
				response = wrapper.send_query('http://rest.decibel.net/v2/album/?id=c')
				Decibel::Wrapper.parse_response(response).should be_nil
			end
		end
	end
	
end