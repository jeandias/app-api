class Api::V1::UsersController < ApplicationController
  include Security

  # POST api/v1/users/validate_password
  def validate_password
    if params[:user].present?
      @user = User.new(user_params)
      render json: password_level_of_security, status: 200
    else
      render json: { error: 'Invalid parameters' }, status: 400
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
