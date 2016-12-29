require 'rails_helper'

RSpec.describe Session::UserPersister do
  subject { described_class.(options) }
  let(:options) { { 'user_params' => user_params } }
  let(:user_params) { attributes_for(:user) }

  context 'when user with such instagram id exists' do
    let!(:user) { create :user, instagram_id: user_params['instagram_id'] }

    it 'returns user' do
      subject
      expect(options['user']).to eq user
    end
  end

  context 'when user with such instagram id not exists' do
    it 'returns new user' do
      allow(User::Create).to receive(:call).with(
        user: user_params
      ).and_return('model' => 'test')
      subject
      expect(options['user']).to eq 'test'
    end
  end
end
