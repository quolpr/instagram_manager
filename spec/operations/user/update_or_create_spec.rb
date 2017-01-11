require 'rails_helper'

RSpec.describe User::UpdateOrCreate do
  subject { described_class.run(user_params) }
  let(:user_params) do
    {
      'instagram_account' => {
        'username' => 'serega_bro_popov',
        'bio' => 'test1',
        'website' => 'test2',
        'profile_picture' => 'test3',
        'full_name' => 'test4',
        'token' => 'token',
        'instagram_id' => instagram_id
      }
    }
  end
  let(:instagram_id) { '51293183' }

  context 'user exists' do
    let!(:user) { create :user }
    let(:instagram_id) { user.instagram_account.instagram_id }

    context 'account exists' do
      it 'updates account data' do
        expect { subject }.to change {
          user.instagram_account.reload.full_name
        }.to('test4')
      end
    end
  end

  context 'user not exists' do
    context 'account exists' do
      let!(:account) { create :instagram_account, instagram_id: instagram_id }

      it 'updates account' do
        expect { subject }.to change {
          account.reload.full_name
        }.to('test4')
      end
    end

    context 'account not exists' do
      it 'creates account' do
        expect { subject }.to change { InstagramAccount.count }.to(1)
      end
    end

    it 'creates new user' do
      expect { subject }.to change { User.count }.to(1)
    end
  end
end
