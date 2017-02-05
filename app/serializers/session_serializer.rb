# frozen_string_literal: true
class SessionSerializer < ActiveModel::Serializer
  attributes :access_token
  has_one :user
end
