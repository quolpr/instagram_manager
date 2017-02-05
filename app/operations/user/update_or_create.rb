# frozen_string_literal: true
class User::UpdateOrCreate < Operation
  def initialize(user_params)
    @user_params = user_params
    @new_record = false
  end

  def run
    account = nil
    in_transaction do
      account = update_or_create_account
      account.create_user! if account.user.blank?
    end
    RecentMediaWorker.perform_async(account.id) if @new_record
    account.user
  end

  private

  def update_or_create_account
    account = InstagramAccount.find_by(
      instagram_id: @user_params['instagram_account']['instagram_id']
    ) || InstagramAccount.new
    account.assign_attributes(@user_params['instagram_account'])
    @new_record = account.new_record?
    account.save!
    account
  end
end
