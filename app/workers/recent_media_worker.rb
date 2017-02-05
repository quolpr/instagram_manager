# frozen_string_literal: true
class RecentMediaWorker
  PER_PAGE = 100

  include Sidekiq::Worker

  attr_writer :client

  def perform(account_id)
    @account = InstagramAccount.find(account_id)
    ActiveRecord::Base.transaction(&method(:scrap))
  end

  private

  def scrap(count: PER_PAGE, max_id: nil)
    recent_media = client.user_recent_media(count: count, max_id: max_id)
    recent_media.each do |media|
      @account.media_objects.create!(normailze_data(media))
    end
    next_id = recent_media.pagination['next_max_id']
    scrap(max_id: next_id) if next_id.present?
  end

  def normailze_data(media)
    {
      link: media['link'],
      tags: media['tags'],
      created_time: Time.at(media['created_time'].to_i).utc,
      caption: media.dig('caption', 'text'),
      media_type: media['type'],
      instagram_id: media['id']
    }.tap do |params|
      send("parse_#{media['type']}", params, media)
    end
  end

  def parse_image(params, media)
    params[:media_url] = media.dig('images', 'standard_resolution', 'url')
  end

  def parse_video(params, media)
    params[:media_url] = media.dig('videos', 'standard_resolution', 'url')
  end

  def client
    @client ||= Instagram.client(access_token: @account.token)
  end
end
