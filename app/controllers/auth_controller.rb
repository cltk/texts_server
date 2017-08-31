class AuthController < ApplicationController
  respond_to :json

  def callback
    user = User.find_or_create_from_auth_hash(auth_hash)
    render nothing: true, status: 200
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
