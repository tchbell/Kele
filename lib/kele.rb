require 'httparty'

class Kele
    include HTTParty
    
    def initialize(email, password)
        @email = email
        @password = password
        @api_url = 'https://www.bloc.io/api/v1/sessions'
        values = {"email": @email, "password": @password}
        @user_auth_token = self.class.post(@api_url, values)
        
    end
end