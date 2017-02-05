# frozen_string_literal: true
class InstagramAccountsController < ApplicationController
  def index
    render json: InstagramAccount.all,
           each_serializer: InstagramAccountSerializer
  end
end
