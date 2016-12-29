require 'rails_helper'

RSpec.describe Session::Step::InstagramUserByCode do
  subject { Session::Step::InstagramUserByCode.(options, params: params) }

  before do
    allow(Instagram).to receive(:get_access_token).and_return(token_response)
  end

  let(:params) { { 'code' => code } }
  let(:code) { '123' }
  let(:token_response) do
    { 'access_token' => 'token12',
      'user' =>
      { 'username' => 'serega_bro_popov',
        'bio' => 'test1',
        'website' => 'test2',
        'profile_picture' => 'test3',
        'full_name' => 'test4',
        'id' => '51293183' } }
  end
  let(:options) { {} }

  it 'requests access token' do
    expect(Instagram).to receive(:get_access_token).with(
      code, redirect_uri: ENV['CALLBACK_URL']
    )
    subject
  end

  it 'returns normalized user params' do
    expect(subject['instagram_account']).to eq(
      'instagram_id' => '51293183',
      'token' => 'token12',
      'username' => 'serega_bro_popov',
      'bio' => 'test1',
      'website' => 'test2',
      'profile_picture' => 'test3',
      'full_name' => 'test4'
    )
  end
end
