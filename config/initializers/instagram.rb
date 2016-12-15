Instagram.configure do |config|
  config.client_id = ENV['INSTAGRAM_ID']
  config.client_secret = ENV['INSTAGRAM_SECRET']
end

InstagramOAuth = OAuth2::Client.new(
  ENV['INSTAGRAM_ID'],
  ENV['INSTAGRAM_SECRET'],
  site: ENV['HOST']
)
