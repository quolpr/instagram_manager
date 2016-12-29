class Session::Step::InstagramUserByCode
  extend Uber::Callable

  def self.call(options, params:, **)
    response = Instagram.get_access_token(
      params['code'], redirect_uri: ENV['CALLBACK_URL']
    )
    account_params = response['user'].tap do |a_params|
      a_params['instagram_id'] = a_params.delete('id')
      a_params['token'] = response['access_token']
    end
    options['user_params'] = { 'instagram_account' => account_params }
  end
end
