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

require 'rails_helper'

RSpec.describe InstagramAccount, type: :model do
  it { should have_many :media_objects }
  it { should belong_to :user }
end
