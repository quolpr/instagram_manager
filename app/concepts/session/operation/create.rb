class Session::Operation::Create < Trailblazer::Operation
  step Session::Step::InstagramUserByCode
  step Session::Step::UpdateOrCreateUser
  step Session::Step::EncodeToken
  step Session::Step::BuildSession
end
