class Api::V1::UsersController < ApplicationController

  # POST api/v1/users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user
    else
      render json: { error: @user.errors.messages }, status: 400
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
