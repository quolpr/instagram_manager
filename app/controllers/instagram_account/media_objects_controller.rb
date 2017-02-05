# frozen_string_literal: true
class InstagramAccount::MediaObjectsController < ApplicationController
  def index
    render json: InstagramAccount.find(params[:instagram_account_id]).media_objects,
           each_serializer: InstagramAccount::MediaObjectSerializer
  end
end
