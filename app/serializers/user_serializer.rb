# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  instagram_token :string
#  instagram_id    :string
#  username        :string
#  full_name       :string
#  profile_picture :string
#  bio             :string
#  website         :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class UserSerializer < ActiveModel::Serializer
  attributes :id, :instagram_id, :username,
             :full_name, :profile_picture, :bio,
             :website
end
