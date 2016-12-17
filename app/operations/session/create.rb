class Session::Create < Trailblazer::Operation
  step :user_params_by_code
  step :find_or_create_user
  step :build_session

  def user_params_by_code(options)
    response = Instagram.get_access_token(
      options['code'], redirect_uri: ENV['CALLBACK_URL']
    )
    options['user_params'] = response['user'].merge(
      'instagram_token' => response['access_token']
    ).tap do |user_params|
      user_params['instagram_id'] = user_params.delete('id')
    end
    options
  end

  def find_or_create_user(options)
    options['user'] = User.find_by(
      instagram_id: options['user_params']['instagram_id']
    ) || begin
      User::Create.(user: options['user_params'])['model']
    end
    options
  end

  def build_session(options)
    options['model'] = Session.new(
      user: options['user'],
      access_token: JwtService.encode(user_id: options['user'].id)
    )
    options
  end
end
