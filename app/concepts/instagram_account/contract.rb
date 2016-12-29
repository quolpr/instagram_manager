require 'reform/form/validation/unique_validator'

class InstagramAccount::Contract < Reform::Form
  property :token, validates: { presence: true }
  property :instagram_id, validates: { presence: true, unique: true }
  property :username, validates: { presence: true }
  property :full_name
  property :profile_picture
  property :bio
  property :website
end
