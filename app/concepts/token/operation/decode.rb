class Token::Operation::Decode < Trailblazer::Operation
  step :process!

  def process!(options, params:)
    options['result'] = JWT.decode(
      params, ENV['JWT_SECRET'], true, algorithm: 'HS256'
    ).first
  end
end
