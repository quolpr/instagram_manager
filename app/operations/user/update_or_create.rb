class User::UpdateOrCreate < Operation
  def initialize(user_params)
    @user_params = user_params
  end

  def run
    in_transaction do
      account = update_or_create_account
      account.create_user! if account.user.blank?
      account.user
    end
  end

  private

  def update_or_create_account
    account = InstagramAccount.find_by(
      instagram_id: @user_params['instagram_account']['instagram_id']
    ) || InstagramAccount.new
    account.assign_attributes(@user_params['instagram_account'])
    account.save!
    account
  end
end
