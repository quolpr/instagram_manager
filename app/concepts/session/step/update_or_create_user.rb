class Session::Step::UpdateOrCreateUser
  extend Uber::Callable

  def self.call(options, **)
    result = User::Operation::UpdateOrCreate.(
      options['user_params']
    )
    options['user'] = result['model']
    result.success?
  end
end
