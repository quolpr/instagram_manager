class Session::Step::EncodeToken
  extend Uber::Callable

  def self.call(options, **)
    result = Token::Operation::Encode.(
      user_id: options['user'].id
    )
    options['token'] = result['result']
    result.success?
  end
end
