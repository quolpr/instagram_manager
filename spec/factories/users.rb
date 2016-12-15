# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  instagram_token :string
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :user do
    instagram_token "MyString"
    username "MyString"
  end
end
