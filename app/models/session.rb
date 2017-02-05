# frozen_string_literal: true
class Session < ActiveModelSerializers::Model
  attr_accessor :access_token, :user
end
