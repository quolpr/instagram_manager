# frozen_string_literal: true
class InstagramAccount::MediaObjectSerializer < ActiveModel::Serializer
  attributes :id, :link, :media_url, :tags, :created_time, :caption, :media_type, :instagram_id
end
