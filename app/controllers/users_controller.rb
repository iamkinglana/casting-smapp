class UsersController < ApplicationController

    def signup
      user = User.new(user_params)
      if user.save
        render json: { message: 'User created successfully' }
      else
        render json: { error: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def login
      user = User.find_by(email: params[:email])
      if user&.authenticate(params[:password])
        # Generate and return a token
      else
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end
    end

    def logout
      # Handle user logout by invalidating the token
    end

    def update
      user = User.find(params[:id])
      if user.update(user_params)
        render json: { message: 'User updated successfully' }
      else
        render json: { error: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.permit(:username, :email, :password)
    end-

end
