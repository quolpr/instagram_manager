class SessionsController < ApplicationController
  def create
    p InstagramOAuth.auth_code.get_token(params['client_id'], redirect_uri: ENV['CALLBACK_URL'])
  end
end
