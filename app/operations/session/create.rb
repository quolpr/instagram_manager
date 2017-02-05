# frozen_string_literal: true
class Session::Create < Operation
  def initialize(code)
    @code = code
  end

  def run
    build_session(
      User::UpdateOrCreate.run(user_params)
    )
  end

  private

  def user_params
    response = Instagram.get_access_token(
      @code, redirect_uri: ENV['CALLBACK_URL']
    )
    account_params = response['user'].to_h.tap do |a_params|
      a_params['instagram_id'] = a_params.delete('id')
      a_params['token'] = response['access_token']
    end
    { 'instagram_account' => account_params }
  end

  def build_session(user)
    Session.new(
      user: user,
      access_token: JwtService.encode(user_id: user.id)
    )
  end
end
