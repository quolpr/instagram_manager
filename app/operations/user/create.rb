require 'reform/form/validation/unique_validator'

class User::Create < Trailblazer::Operation
  include Model
  model User, :create

  contract do
    property :instagram_token, validates: { presence: true }
    property :instagram_id, validates: { presence: true, unique: true }
    property :username, validates: { presence: true }
    property :full_name
    property :profile_picture
    property :bio
    property :website
  end

  def process(params)
    validate(params[:user]) do
      contract.save
    end
  end
end
