require 'rails_helper'

RSpec.describe Session::Create do
  subject { described_class.(code: code) }
  let(:code) { 123 }

  let(:token_response) do
    { 'access_token' => 'token',
      'user' =>
      { 'username' => 'serega_bro_popov',
        'bio' => '',
        'website' => '',
        'profile_picture' => '',
        'full_name' => '',
        'id' => '51293183' } }
  end

  it 'gets access token based on code' do
    expect(Instagram).to receive(:get_access_token).with(
      code, redirect_uri: ENV['CALLBACK_URL']
    ).and_return(token_response)
    subject
  end

  describe '#self.update_or_create_user' do
    subject { described_class.new.update_or_create_user(token_response) }
    let(:user) { create :user, instagram_id: exists_instagram_id }
    let(:exists_instagram_id) { '51293183' }

    context 'when user with such instagram exists' do
      it 'returns user' do

      end
    end
    context 'when user with such instagram not exists' do
      let(:exists_instagram_id) { '123' }

      it 'creates new user' do
        expect(User::Create).to receive(:call).with(
          user: token_response['user'].merge('instagram_token' => 'token')
        ).and_return(user_create_result)
        subject
      end
      it 'returns user'
    end
  end

  describe '#proccess' do

  end

  describe 'user authorizing' do
    before { allow(Instagram).to receive(:get_access_token).and_return(token_response) }
    context 'when instagram user exists' do

      it 'encodes JWT token' do
        expect(JwtService).to receive(:encode).with(
          user_id: user.id
        ).and_return('test')
        expect(subject.model).to eq 'test'
      end
    end

    context 'when instagram user not exists' do
      let(:user_create_result) { double(model: new_user) }
      let(:new_user) { build :user, id: 1 }
      let(:exists_instagram_id) { '123' }

      it 'creates new user' do
        expect(User::Create).to receive(:call).with(
          user: token_response['user'].merge('instagram_token' => 'token')
        ).and_return(user_create_result)
        subject
      end

      it 'encodes JWT token' do
        allow(User::Create).to receive(:call).and_return(user_create_result)
        expect(JwtService).to receive(:encode).with(
          user_id: new_user.id
        ).and_return('test')
        subject
      end

      it 'returns session object' do
        allow(User::Create).to receive(:call).and_return(user_create_result)
      end
    end
  end
end
