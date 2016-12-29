require 'rails_helper'

RSpec.describe User::Operation::UpdateOrCreate do
  subject { User::Operation::UpdateOrCreate.(params) }
  let(:params) { { instagram_account: instagram_account_attrs } }
  let(:instagram_account_attrs) { attributes_for(:instagram_account) }
  context 'user not exists' do
    it 'creates new user' do
      expect { subject }.to change { User.count }
    end

    it 'creates new instagram account' do
      expect { subject }.to change { InstagramAccount.count }
    end

    it { is_expected.to be_success }
  end

  context 'account exists' do
    context 'user exists' do
      let!(:user) do
        create :user, instagram_account: instagram_account
      end
      let(:instagram_account) do
        InstagramAccount.new(instagram_account_attrs.merge(token: '123'))
      end
      let(:params) do
        {
          instagram_account: {
            token: '321',
            instagram_id: instagram_account_attrs[:instagram_id]
          }
        }
      end

      it 'updates instagram account' do
        expect { subject }.to change { instagram_account.reload.token }.to('321')
      end

      it { is_expected.to be_success }
    end

    context 'user not exists' do
      let!(:instagram_account) do
        InstagramAccount.create!(instagram_account_attrs)
      end

      it 'creates new user for account' do
        expect { subject }.to change {
          instagram_account.reload.user.present?
        }.to(true)
      end

      it { is_expected.to be_success }
    end
  end
end
