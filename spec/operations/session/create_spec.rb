# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Session::Create do
  subject { described_class.run(code) }
  let(:code) { '123' }
  let(:token_response) do
    { 'access_token' => 'token',
      'user' =>
      { 'username' => 'serega_bro_popov',
        'bio' => 'test1',
        'website' => 'test2',
        'profile_picture' => 'test3',
        'full_name' => 'test4',
        'id' => '51293183' } }
  end
  let(:user) { create :user }

  before do
    allow(User::UpdateOrCreate).to receive(:run).and_return(user)
    allow(Instagram).to receive(:get_access_token).and_return(token_response)
    allow(JwtService).to receive(:encode).and_return('test123')
  end

  it 'gets user info by instagram api' do
    expect(Instagram).to receive(:get_access_token).with(
      code, redirect_uri: 'http://localhost:3000/oauth/authorize'
    )
    subject
  end

  it 'updates or creates user' do
    expect(User::UpdateOrCreate).to receive(:run).with(
      'instagram_account' => {
        'username' => 'serega_bro_popov',
        'bio' => 'test1',
        'website' => 'test2',
        'profile_picture' => 'test3',
        'full_name' => 'test4',
        'token' => 'token',
        'instagram_id' => '51293183'
      }
    )
    subject
  end

  it 'returns session object' do
    expect(subject.user).to be user
    expect(subject.access_token).to eq 'test123'
  end
end
