class UsersController < ApplicationController
  def show
    user = User.find_by(id: params[:id])

    if user
      user_data = {
        id: user.id,
        username: user.username,
        # bio: user.bio,
        following: user.following.count,
        followers: user.followers.count,
        casts: user.casts.map do |cast|
          {
            id: cast.id,
            content: cast.content,
            author: cast.user.username,
            timestamp: cast.created_at,
            likes: cast.likes&.count || 0,
            comments: cast.comments&.count || 0
          }
        end
      }

      render json: user_data
    else
      render json: { error: 'User not found' }, status: :not_found
    end
  end

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
      token = generate_token(user.id)
      render json: { token: token }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def logout
    # Handle user logout by invalidating the token
    # Example: You might have a current_user method that retrieves the user based on the token and set it to nil.
    # current_user = nil
    render json: { message: 'User logged out successfully' }
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
    params.permit(:username, :email, :password, :bio, :avatar) # Add additional attributes as needed
  end

  def generate_token(user_id)
    secret_key = Rails.application.secrets.secret_key_base
    payload = { user_id: user_id }
    token = JWT.encode(payload, secret_key, 'HS256')
    return token
  end
end
