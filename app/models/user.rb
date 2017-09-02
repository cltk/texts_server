class User < ApplicationRecord
  def self.find_or_create_from_auth_hash(auth_hash)
    provider = auth_hash['provider']

    find_or_initialize_by({ "#{provider}_uid" => auth_hash['uid'] }) do |u|
      u.update!(User.update_hash(auth_hash))
    end
  end

  def self.update_hash(auth_hash)
    provider = auth_hash['provider']
    credentials = auth_hash['credentials']
    info = auth_hash['info']

    h = {
      "email" => u.email || info['email'],
      "#{provider}_access_token" => credentials['token'],
      "#{provider}_username" => u.username || info['nickname']
    }

    if User.method_defined?("#{provider}_secret")
      h["#{provider}_secret"] = credentials['secret']
    end

    if User.method_defined?("#{provider}_refresh_token")
      h["#{provider}_refresh_token"] = credentials['refresh_token']
    end

    h
  end
end
