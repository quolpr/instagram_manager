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

FactoryGirl.define do
  factory :instagram_account do
    token '123321'
    sequence(:instagram_id) { |n| n }

    username 'snoopdogg'
    full_name 'Snoop Dogg'
    profile_picture Faker::Avatar.image
    bio 'This is my bio'
    website 'http://snoopdogg.com'
  end
end
