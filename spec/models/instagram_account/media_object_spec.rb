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

require 'rails_helper'

RSpec.describe InstagramAccount::MediaObject, type: :model do
  it { should belong_to :instagram_account }
end
