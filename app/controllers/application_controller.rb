class ApplicationController < ActionController::API

  before_action :authorized

  def issue_token(payload)
    token = JWT.encode(payload, "pickle")
  end

  def auth_header
     header = request.headers['Authorization']
  end

 def decoded_token
    if auth_header
      begin
        JWT.decode(auth_header, "pickle", true, {algorithm: 'HS256'})
      rescue JWT::DecodeError
        [{}]
      end
    else
    end
  end

  def current_user
     if decoded_token
       if user_id = decoded_token[0]["user_id"]
         @user = User.find(user_id)
       else
       end
     else
     end
   end

  def logged_in?
      !!current_user
  end

  def authorized
    render json: {message: "Please Login" }, status: 401 unless logged_in?
  end
end
