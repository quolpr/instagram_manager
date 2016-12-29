class User::Operation::UpdateOrCreate < Trailblazer::Operation
  extend Contract::DSL

  contract do
    property :instagram_account,
             form: InstagramAccount::Contract,
             populate_if_empty: InstagramAccount
  end

  step :find_or_build
  step Contract::Build()
  step Contract::Validate()
  step Contract::Persist()

  def find_or_build(options, params:)
    account = InstagramAccount.find_by(
      instagram_id: params['instagram_account']['instagram_id']
    )
    options['model'] = if account.present?
                         account.user.present? ? account.user : account.build_user
                       else
                         User.new
                       end
  end
end
