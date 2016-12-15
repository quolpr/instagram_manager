class Session::Create < Trailblazer::Operation
  def process(params)
    @response = Instagram.get_access_token(
      params[:code], redirect_uri: ENV['CALLBACK_URL']
    )
    user = User.find_by(instagram_id: user_params['id']) || begin
      User::Create.(user: user_params).model
    end
    @model = JwtService.encode(user_id: user.id)
  end

  def user_params
    @user_params ||= @response['user'].merge(
      'instagram_token' => @response['access_token']
    )
  end

  def self.update_or_create_user(token_response)

  end
end
