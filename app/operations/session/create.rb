class Session::Create < Trailblazer::Operation
  def process(params)
    user_params = user_params_by_code(params[:code])
    user = find_or_create_user(user_params)
    @model = build_session(user)
  end

  def user_params_by_code(code)
    response = Instagram.get_access_token(
      code, redirect_uri: ENV['CALLBACK_URL']
    )
    response['user'].merge(
      'instagram_token' => response['access_token']
    ).tap do |user_params|
      user_params['instagram_id'] = user_params.delete('id')
    end
  end

  def find_or_create_user(user_params)
    User.find_by(instagram_id: user_params['instagram_id']) || begin
      User::Create.(user: user_params).model
    end
  end

  def build_session(user)
    Session.new(
      user: user,
      access_token: JwtService.encode(user_id: user.id)
    )
  end
end
