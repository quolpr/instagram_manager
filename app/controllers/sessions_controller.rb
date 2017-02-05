# frozen_string_literal: true
class SessionsController < ApplicationController
  def new
    redirect_to Instagram.authorize_url(
      redirect_uri: ENV['CALLBACK_URL']
    )
  end

  def create
    render json: Session::Create.run(params[:code]),
           include: 'user,user.instagram_account',
           serializer: SessionSerializer
  end
end
