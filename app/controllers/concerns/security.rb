module Security
  include ActiveSupport::Concern
  include Blacklist

  def password_level_of_security
    if @user.valid? && !blacklisted?
      { user: @user, error: [], strength: 'STRONG' }

    elsif @user.password.blank?
      { error: @user.errors.messages[:password], strength: nil }

    elsif @user.password.length >= 6 && @user.errors.messages[:password].size == 1
      { error: @user.errors.messages[:password], strength: 'OK' }

    elsif blacklisted? || @user.errors.messages[:password].size >= 1
      if blacklisted?
        @user.errors.messages[:password] << 'This password is blacklisted'
      end

      { error: @user.errors.messages[:password], strength: 'WEAK' }
    end
  end
end
