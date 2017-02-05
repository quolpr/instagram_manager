# frozen_string_literal: true
# == Schema Information
#
# Table name: instagram_accounts
#
#  id              :integer          not null, primary key
#  token           :string
#  instagram_id    :string
#  username        :string
#  full_name       :string
#  profile_picture :string
#  bio             :string
#  website         :string
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class InstagramAccountSerializer < ActiveModel::Serializer
  attributes :id, :instagram_id, :username,
             :full_name, :profile_picture, :bio,
             :website

  has_many :media_objects do
    link(:related) { instagram_account_media_objects_path(object.id) }

    object.media_objects.none
  end
end
