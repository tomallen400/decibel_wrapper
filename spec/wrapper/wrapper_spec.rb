require 'spec_helper'

describe Decibel::Wrapper do
	
	let(:wrapper) { $wrapper }
	let(:test_query) { "albums/?title=the%20fame%20monster&depth=Tracks;TrackAuthors" }
	let(:album_query) { "album/?id=cd94ce57-533a-e311-be6d-ac220b82800d" }
	subject { wrapper }
	
	it { should respond_to(:decibel_app_id) }
	it { should respond_to(:decibel_app_key) }
	
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
	
	describe "disctags"
	
	describe "image" do
		context "when passed a valid id" do
			it "should return a string of the file" do
				wrapper.image(:id => "ad4c211d-45a8-e211-9400-bcaec56d8fb5").should be_an_instance_of String
			end
		end
		context "when passed an invalid id" do
			it "should return nil" do
				wrapper.image(:id => "something_else").should be_nil
			end
		end
		context "when passed no id" do
			it "should return nil" do
				wrapper.image(nil).should be_nil
			end
		end
	end
	
	describe "image_size" do
		it "should return a string" do
			Decibel::Wrapper.image_size(nil).should be_an_instance_of String
		end
		it "should default to standard" do
			Decibel::Wrapper.image_size(nil).should == "standard"
		end
		it "should return thumbnail if passed thumbnail in the params" do
			Decibel::Wrapper.image_size(:thumbnail => true).should == "thumbnail"
		end
		it "should return standard if passed thumbnail as false" do
			Decibel::Wrapper.image_size(:thumbnail => false).should == "standard"
		end
		it "should return full if passed full in the params" do
			Decibel::Wrapper.image_size(:full => true).should == "full"
		end
	end
	
	describe "participant" do
		context "when passed a valid id" do
			it "should return an instance of Decibel::Participant" do
				wrapper.participant(:id => 'dd8b7421-463a-e311-be6d-ac220b82800d').should be_an_instance_of Decibel::Participant
			end
		end
		context "when passed an invalid id" do
			it "should return nil" do
				wrapper.participant(:id => 'something_else').should be_nil
			end
		end
	end
	
	describe "participants" do
		context "when finding something" do
			it "should return an array" do
				wrapper.participants(:name => 'Mick Jagger').should be_an_instance_of Array
			end
			it "should return an array of Decibel::Participant" do
				wrapper.participants(:name => 'Mick Jagger').first.should be_an_instance_of Decibel::Participant
			end
		end
		context "when finding nothing" do
			it "should return an empty array" do
				wrapper.participants(:name => 'blank person').should == []
			end
		end
	end
	
	describe "recording" do
		context "when passed a valid id" do
			it "should return an instance of Decibel::Recording" do
				wrapper.recording(:id => '5e9c115a-7e00-11e3-be7b-ac220b82800d').should be_an_instance_of Decibel::Recording
			end
		end
		context "when passed an invalid id" do
			it "should return nil" do
				wrapper.recording(:id => 'something_else').should be_nil
			end
		end
	end
	
	describe "recordings" do
		context "when finding something" do
			it "should return an array" do
				wrapper.recordings(:artistname => 'The Rolling Stones').should be_an_instance_of Array
			end
			it "should return an array of Decibel::Recording" do
				wrapper.recordings(:artistname => 'The Rolling Stones').first.should be_an_instance_of Decibel::Recording
			end
		end
		context "when finding nothing" do
			it "should return an empty array" do
				wrapper.recordings(:artistname => 'blank person').should == []
			end
		end
	end
	
	describe "return_number" do
		it "should return 1" do
			wrapper.return_number.should == "1"
		end
	end
	
	describe "work" do
		context "when passed a valid id" do
			it "should return an instance of Decibel::Work" do
				wrapper.work(:id => '5e9c115c-7e00-11e3-be7b-ac220b82800d').should be_an_instance_of Decibel::Work
			end
		end
		context "when passed an invalid id" do
			it "should return nil" do
				wrapper.work(:id => 'something_else').should be_nil
			end
		end
	end
	
	describe "works" do
		context "when finding something" do
			it "should return an array" do
				wrapper.works(:workname => 'The Zephyr Song').should be_an_instance_of Array
			end
			it "should return an array of Decibel::Work" do
				wrapper.works(:workname => 'The Zephyr Song').first.should be_an_instance_of Decibel::Work
			end
		end
		context "when finding nothing" do
			it "should return an empty array" do
				wrapper.works(:authornames => 'blank person').should == []
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