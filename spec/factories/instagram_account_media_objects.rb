# frozen_string_literal: true
# == Schema Information
#
# Table name: instagram_account_media_objects
#
#  id                   :integer          not null, primary key
#  instagram_account_id :integer
#  link                 :string
#  media_url            :string
#  tags                 :jsonb
#  created_time         :datetime
#  caption              :string
#  media_type           :string
#  instagram_id         :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

FactoryGirl.define do
  factory :instagram_account_media_object, class: 'InstagramAccount::MediaObject' do
    instagram_account nil
    link 'MyString'
    image 'MyString'
    tags ''
    created_time '2017-01-19 00:23:59'
    caption 'MyString'
    media_type 'MyString'
  end
end
