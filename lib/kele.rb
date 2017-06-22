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
    
    def get_messages(page_num = 0)
        if page_num === 0
            response = self.class.get("https://www.bloc.io/api/v1/message_threads", values:{page: 0}, headers: {"authorization" => @auth_token }).body
            JSON.parse(response)
        else
            response = self.class.get("https://www.bloc.io/api/v1/message_threads", values:{page: page_num}, headers: {"authorization" => @auth_token }).body
            JSON.parse(response)
        end
    end
    
    def create_message(sender, recipient_id, token = nil, subject, message)
        values = {"sender": sender,
                "recipient_id": recipient_id,
                "token": token,
                "subject": subject,
                "stripped-text": message}
        response = self.class.post("https://www.bloc.io/api/v1/messages", body: values, headers: {"authorization" => @auth_token}).body
        JSON.parse(response)
    end
    
    # client.create_message("tchbell@gmail.com", 2362742,"abcd", "Royable with cheese", "Thats what they call a quater pouder in France.")  
    
    def create_submission(assignment_branch, assignment_commit_link, checkpoint_id, comment, enrollment_id)
        values = {
            "assignment_branch": assignment_branch,
            "assignment_commit_link": assignment_commit_link,
            "checkpoint_id": checkpoint_id,
            "comment": comment,
            "enrollment_id": enrollment_id
            }
        response = self.class.post("https://www.bloc.io/api/v1/checkpoint_submissions", body: values, headers: {"authorization" => @auth_token}).body
        JSON.parse(response)
    end
    # client.create_submission("assignment-22-iterative-search", "https:/github.com/me/repo/commit/5", 1635, "This is my work", 11218)
    
    
    
end