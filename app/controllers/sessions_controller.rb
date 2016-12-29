class SessionsController < ApplicationController
  def new
    redirect_to Instagram.authorize_url(
      redirect_uri: ENV['CALLBACK_URL']
    )
  end

  def create
    result = Session::Operation::Create.(params)
    if result.success?
      return render json: result['model'],
                    include: 'user',
                    serializer: SessionSerializer
    else
      render status: :unauthorized
    end
  end
end
