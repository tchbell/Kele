require 'httparty'
require 'json'
require './lib/roadmap.rb'

class Kele
    include HTTParty
    include Roadmap
    

    
    def initialize(email, password)
        @api_url = 'https://www.bloc.io/api/v1/sessions'
        values = {"email": email, "password": password}
        response = self.class.post(@api_url, body: values)
        @auth_token = response["auth_token"]
    end
    
    
    def get_me
        response = self.class.get("https://www.bloc.io/api/v1/users/me", headers: { "authorization" => @auth_token }).body
        JSON.parse(response)
    end
    
    # mentor id = 2290632 
    
    def get_mentor_availability(mentor_id)
        response = self.class.get("https://www.bloc.io/api/v1/mentors/#{mentor_id}/student_availability", headers: { "authorization" => @auth_token}).body
        JSON.parse(response)
    end
    
    
    
end