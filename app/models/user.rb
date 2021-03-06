# frozen_string_literal: true
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

class User < ApplicationRecord
  has_one :instagram_account
end
