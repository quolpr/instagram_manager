class Session::Step::BuildSession
  extend Uber::Callable

  def self.call(options, **)
    options['model'] = Session.new(
      user: options['user'],
      access_token: JwtService.encode(user_id: options['user'].id)
    )
  end
end
