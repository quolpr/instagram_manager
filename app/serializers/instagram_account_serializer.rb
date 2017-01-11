class InstagramAccountSerializer < ActiveModel::Serializer
  attributes :id, :instagram_id, :username,
             :full_name, :profile_picture, :bio,
             :website
end
