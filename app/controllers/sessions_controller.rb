class SessionsController < ApplicationControlle
  def new
    redirect_to Instagram.authorize_url(
      redirect_uri: ENV['CALLBACK_URL']
    )
  end

  def create
    run Session::Create do |op|
      return render json: op.model
    end
    redirect_to root_path
  end
end
