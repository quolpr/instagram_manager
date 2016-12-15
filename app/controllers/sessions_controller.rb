class SessionsController < ApplicationController
  def new
    redirect_to Instagram.authorize_url(
      redirect_uri: ENV['CALLBACK_URL']
    )
  end

  def create
    run Session::Create do |op|
      return render json: op.model, include: 'user'
    end
    render status: :unauthorized
  end
end
