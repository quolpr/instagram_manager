# frozen_string_literal: true
require 'rails_helper'
require 'hashie'

RSpec.describe RecentMediaWorker, type: :worker do
  subject { worker.perform(nil) }
  let(:worker) { RecentMediaWorker.new }

  let(:client) { double(user_recent_media: user_recent_media) }
  let(:user_recent_media) { build_response(file, {}) }

  let(:file) { 'spec/fixtures/1.json' }
  let(:account) { create :instagram_account }
  let(:media) { account.media_objects.last }

  before { allow(InstagramAccount).to receive(:find).and_return(account) }
  before { worker.client = client }

  it 'saves needed info' do
    subject

    expect(media.link).to eq 'https://www.instagram.com/p/BNLKwp10/'
    expect(media.tags).to eq %w(test_1 test_2)
    expect(media.created_time).to eq Time.at(1_479_951_002).utc
    expect(media.caption).to eq 'hello!'
  end

  context 'when image' do
    it 'saves image info' do
      subject

      expect(media.media_url).to eq 'https://scontent.cdninstagram.com/t51.2885-15/s640x640'
      expect(media.media_type).to eq 'image'
    end
  end

  context 'when video' do
    let(:file) { 'spec/fixtures/video.json' }
    it 'saves video info' do
      subject

      expect(media.media_url).to eq 'http://distilleryvesper9-13.ak.instagram.com/test.mp4'
      expect(media.media_type).to eq 'video'
    end
  end

  context 'when pagination is present' do
    let(:pagination) do
      {
        'next_url' => 'https://api.instagram.com/v1/users/51293183/media/recent',
        'next_max_id' => '123'
      }
    end

    before do
      allow(client).to receive(:user_recent_media).and_return(
        build_response('spec/fixtures/1.json', pagination),
        build_response('spec/fixtures/2.json', {})
      )
    end

    it 'calls api in right order' do
      expect(client).to receive(:user_recent_media).with(
        count: 100, max_id: nil
      ).ordered
      expect(client).to receive(:user_recent_media).with(
        count: 100, max_id: '123'
      ).ordered
      subject
    end

    it 'saves all media' do
      expect { subject }.to change { InstagramAccount::MediaObject.count }.to(2)
    end
  end

  def build_response(file, pagination)
    Instagram::Response.create(
      double(
        data: JSON.parse(File.read(file)),
        pagination: pagination,
        meta: {}
      ), {}
    )
  end
end
