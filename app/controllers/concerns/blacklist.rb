module Blacklist
  include ActiveSupport::Concern

  def blacklist
    file_path = File.expand_path(File.join(Rails.root, 'app', 'data', 'password_blacklist.txt'), __FILE__)

    @data ||= File.read(file_path)
  end

  def blacklisted?
    !!blacklist.match(@user.password)
  end
end
