require 'rails_helper'

RSpec.describe User::Create do
  subject { described_class.(user: params) }
  let(:params) { attributes_for(:user) }

  it 'creates new user' do
    expect(subject.model).to be_persisted
  end

  context 'when invalid' do
    let(:params) { attributes_for(:user).merge(instagram_token: '') }
    it 'raises error' do
      expect { subject }.to raise_error(Trailblazer::Operation::InvalidContract)
    end
  end

  context 'when token not present' do
    let(:params) { attributes_for(:user).merge(instagram_token: '') }

    it 'fails' do
      expect { subject }.to raise_error(Trailblazer::Operation::InvalidContract)
    end
  end

  context 'when username not present' do
    let(:params) { attributes_for(:user).merge(username: '') }

    it 'fails' do
      expect { subject }.to raise_error(Trailblazer::Operation::InvalidContract)
    end
  end

  context 'when instagram_id not present' do
    let(:params) { attributes_for(:user).merge(instagram_id: '') }

    it 'fails' do
      expect { subject }.to raise_error(Trailblazer::Operation::InvalidContract)
    end
  end

  context 'when instagram_id not uniq' do
    let(:user) { create :user }
    let(:params) { attributes_for(:user).merge(instagram_id: user.instagram_id) }

    it 'fails' do
      expect { subject }.to raise_error(Trailblazer::Operation::InvalidContract)
    end
  end
end
