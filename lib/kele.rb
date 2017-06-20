require 'httparty'

class Kele
    include HTTParty
    
    def initialize(email, password)
        @api_url = 'https://www.bloc.io/api/v1/sessions'
        values = {"email": email, "password": password}
        response = self.class.post(@api_url, body: values)
        @auth_token = response["auth_token"]
    end
    
#      def initialize(email, password)
#     response = self.class.post("https://www.bloc.io/api/v1/sessions", body: {"email": email, "password": password})
#     raise "invalid email/pass" if response.code != 200
#     @auth_token = response["auth_token"]
#   end
    
end