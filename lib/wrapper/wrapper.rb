class Decibel::Wrapper
	
	require 'net/https'
	require 'uri'
	require 'json'
	
	attr_accessor :decibel_app_id, :decibel_app_key
	
	@@api_url = "http://rest.decibel.net/v2/"
	
	Dir[File.join(File.dirname(__FILE__), "resources", "*.rb")].each { |file| require file }
  
  def initialize args
  	args.each do |k, v|
  		instance_variable_set("@#{k}", v) unless v.nil?
  	end
  end
  
  def album(params)
  	response = self.query(Decibel::Wrapper.create_query_string('album/?', params))
		Decibel::Album.new(response) if !response.nil?
  end
  
  def albums(params)
  	response = self.query(Decibel::Wrapper.create_query_string('albums/?', params))
		if !response.nil?
			array = []
			response.each do |a|
				array << Decibel::Album.new(response)
			end
			array
		end
  end
  
  def disctags(params)
  
  end
  
  def image(params)
  	image_id = "0"
  	image_id = params[:id] if params.is_a?(Hash) && params[:id]
  	response = self.query("image/#{image_id}/#{Decibel::Wrapper.image_size(params)}")
  end
  
  def self.image_size(params)
  	image_size = "standard"
  	image_size = "thumbnail" if params.is_a?(Hash) && params[:thumbnail]
  	image_size = "full" if params.is_a?(Hash) && params[:full]
  	image_size
  end
  
  def participant(params)
  	response = self.query(Decibel::Wrapper.create_query_string('participant/?', params))
		Decibel::Participant.new(response) if !response.nil?
  end
  
  def participants(params)
  	response = self.query(Decibel::Wrapper.create_query_string('participants/?', params))
		if !response.nil?
			array = []
			response.each do |a|
				array << Decibel::Participant.new(response)
			end
			array
		end
  end
  
  def recording(params)
  	response = self.query(Decibel::Wrapper.create_query_string('recording/?', params))
		Decibel::Recording.new(response) if !response.nil?
  end
  
  def recordings(params)
  	response = self.query(Decibel::Wrapper.create_query_string('recordings/?', params))
		if !response.nil?
			array = []
			response.each do |a|
				array << Decibel::Recording.new(response)
			end
			array
		end
  end
  
  def return_number
  	self.query(Decibel::Wrapper.create_query_string('return/number', nil))
  end
  
  def work(params)
  	response = self.query(Decibel::Wrapper.create_query_string('work/?', params))
		Decibel::Work.new(response) if !response.nil?
  end
  
  def works(params)
  	response = self.query(Decibel::Wrapper.create_query_string('works/?', params))
		if !response.nil?
			array = []
			response.each do |a|
				array << Decibel::Work.new(response)
			end
			array
		end
  end
  
  # Query String
  def self.create_query_string(start, params)
  	if params.is_a?(Hash)
			start += hash_to_query_string(params).join('&')
		else
			start
  	end
  end
  
  def self.hash_to_query_string(hash)
  	array = []
  	hash.each do |k, v|
			array << query_value(k, v)
		end
		array
  end
  
  def self.query_value(k, v)
  	if k.to_s.downcase != "depth" && !v.nil?
			"#{k}=#{URI.encode(v, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))}"
		else
			depth_string(v)
		end
  end
  
  def self.depth_string(hash)
  	string = "depth="
		new_array = []
		hash.each do |depth_k, depth_v|
			new_array << "#{depth_k}" if depth_v == true
		end
		string += new_array.join(';')
  end
  
  # Hit Decibel API
  def query(ending)
  	query = @@api_url + ending
  	response = self.send_query(query)
  	Decibel::Wrapper.parse_response(response)
  end
  
  def send_query(query)
  	uri = URI.parse(query)
  	http = Net::HTTP.new(uri.host, uri.port)
		request = Net::HTTP::Get.new(uri.request_uri)
		request.initialize_http_header('DecibelAppID' => self.decibel_app_id, 
			'DecibelAppKey' => self.decibel_app_key, 
			'DecibelTimestamp' => Time.now.strftime('%Y%m%d %H:%M:%S'))
    http.request(request)
  end
  
  def self.parse_response(response)
		if response.is_a?(Net::HTTPOK)
			json = JSON.parse(response.body) rescue {}
			if json["ResultSet"]
				json["ResultSet"]
			elsif json["Result"]
				json["Result"]
			else
				response.body
			end
  	end
  end
  
end