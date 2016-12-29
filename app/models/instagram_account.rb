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

class InstagramAccount < ApplicationRecord
  belongs_to :user, optional: true
end
