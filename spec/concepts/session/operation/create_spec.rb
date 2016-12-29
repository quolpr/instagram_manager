require 'rails_helper'

RSpec.describe Session::Operation::Create do
  subject { Session::Operation::Create.(code: 'test') }

  before do
    allow(Session::Step::InstagramUserByCode).to receive(:call)
  end
end
