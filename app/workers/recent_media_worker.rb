class RecentMediaWorker
  include Sidekiq::Worker

  def perform(account_id)
    @account = InstagramAccount.find(account_id)
  end

  private

  def client
    @client ||= Instagram.client(access_token: @account.token)
  end
end
