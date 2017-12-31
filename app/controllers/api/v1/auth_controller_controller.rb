class Api::V1::AuthControllerController < ApplicationController

  skip_before_action :authorized, only: [:create]

    def create
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
        token = issue_token({ user_id: user.id})
        render json: { user: user, jwt: token}, status: 200
      else
        render json: {message: "Invalid username or password"}, status: 404
      end
    end

end
