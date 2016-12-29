class Token::Operation::Encode < Trailblazer::Operation
  step :process!

  def process!(options, params:)
    options['result'] = JWT.encode params, ENV['JWT_SECRET'], 'HS256'
  end
end
