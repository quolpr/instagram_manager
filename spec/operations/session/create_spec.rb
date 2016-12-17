require 'rails_helper'

RSpec.describe Session::Create do
  subject(:operation) { described_class.new(code: code) }
  let(:code) { 123 }

  describe '#user_params_by_code' do
    subject { operation.user_params_by_code(options) }

    before do
      allow(Instagram).to receive(:get_access_token).and_return(token_response)
    end

    let(:options) { { 'code' => code } }
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

    it 'requests access token' do
      expect(Instagram).to receive(:get_access_token).with(
        code, redirect_uri: ENV['CALLBACK_URL']
      )
      subject
    end

    it 'returns normalized user params' do
      expect(subject['user_params']).to eq(
        'instagram_id' => '51293183',
        'instagram_token' => 'token',
        'username' => 'serega_bro_popov',
        'bio' => 'test1',
        'website' => 'test2',
        'profile_picture' => 'test3',
        'full_name' => 'test4'
      )
    end
  end

  describe '#find_or_create_user' do
    subject { operation.find_or_create_user(options) }
    let(:options) { { 'user_params' => user_params } }
    let(:user_params) { attributes_for(:user) }

    context 'when user with such instagram id exists' do
      let!(:user) { create :user, instagram_id: user_params['instagram_id'] }

      it 'returns user' do
        expect(subject['user']).to eq user
      end
    end

    context 'when user with such instagram id not exists' do
      it 'returns new user' do
        allow(User::Create).to receive(:call).with(
          user: user_params
        ).and_return('model' => 'test')
        expect(subject['user']).to eq 'test'
      end
    end
  end

  describe '#build_session' do
    subject { operation.build_session(options) }
    let(:options) { { 'user' => user } }
    let(:user) { double(id: 1) }

    it 'creates new token' do
      expect(JwtService).to receive(:encode).with(
        user_id: user.id
      )
      subject
    end

    it 'returns session object' do
      allow(JwtService).to receive(:encode).and_return('test')
      expect(subject['model'].attributes).to eq(
        user: user, access_token: 'test'
      )
    end
  end
end
