class HomeSerializer < ActiveModel::Serializer
  attributes :auth_url

  def auth_url
    InstagramOAuth.auth_code.authorize_url(
      redirect_uri: ENV['CALLBACK_URL']
    )
  end
end
