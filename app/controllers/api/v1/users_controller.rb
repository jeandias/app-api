class Api::V1::UsersController < ApplicationController

  # POST api/v1/users/validate_password
  def validate_password
    if params[:user].present?
      @user = User.new(user_params)
      render json: check_level_of_security, status: 200
    else
      render json: { error: 'Invalid parameters' }, status: 400
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def blacklist
    file_path = File.expand_path(File.join(Rails.root, 'app', 'data', 'password_blacklist.txt'), __FILE__)

    @data ||= File.read(file_path)
  end

  def blacklisted?
    !!blacklist.match(@user.password)
  end

  def check_level_of_security
    if @user.valid? && !blacklisted?
      { user: @user, strength: 'STRONG' }

    elsif @user.password.blank?
      { error: @user.errors.messages, strength: nil }

    elsif @user.errors.messages[:password].size < 2 && @user.password.length >= 6
      { error: @user.errors.messages, strength: 'OK' }

    elsif blacklisted? || @user.errors.messages[:password].size >= 1
      if blacklisted?
        @user.errors.messages[:password] << 'This password is blacklisted'
      end

      { error: @user.errors.messages, strength: 'WEAK' }
    end
  end
end
