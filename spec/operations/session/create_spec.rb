require 'rails_helper'

RSpec.describe Session::Create do
  subject(:operation) { described_class.new(code: code) }
  let(:code) { 123 }

  describe '#user_params_by_code' do
    subject { operation.user_params_by_code(code) }

    before do
      allow(Instagram).to receive(:get_access_token).and_return(token_response)
    end

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
      is_expected.to eq(
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
    subject { operation.find_or_create_user(user_params) }
    let(:user_params) { attributes_for(:user) }

    context 'when user with such instagram id exists' do
      let!(:user) { create :user, instagram_id: user_params['instagram_id'] }

      it 'returns user' do
        is_expected.to eq user
      end
    end

    context 'when user with such instagram id not exists' do
      it 'creates new user' do
        expect { subject }.to change { User.count }.by(1)
      end

      it 'returns new user' do
        is_expected.to be_a User
      end
    end
  end

  describe '#build_session' do
    subject { operation.build_session(user) }
    let(:user) { double(id: 1) }

    it 'creates new token' do
      expect(JwtService).to receive(:encode).with(
        user_id: user.id
      )
      subject
    end

    it 'returns session object' do
      allow(JwtService).to receive(:encode).and_return('test')
      expect(subject.attributes).to eq(
        user: user, access_token: 'test'
      )
    end
  end

  describe '#process' do
    subject { operation.run.last }
    before do
      allow(operation).to receive(:user_params_by_code).and_return({})
      allow(operation).to receive(:find_or_create_user).and_return(user)
      allow(operation).to receive(:build_session).and_return(session)
    end
    let(:user) { User.new }
    let(:session) { Session.new }

    it 'gets user params' do
      expect(operation).to receive(:user_params_by_code).with(code)
      subject
    end

    it 'find or create user by user params' do
      expect(operation).to receive(:find_or_create_user).with({})
      subject
    end

    it 'builds session' do
      expect(operation).to receive(:build_session).with(user)
      subject
    end

    it 'sets models as sessions' do
      expect(subject.model).to eq session
    end
  end
end
