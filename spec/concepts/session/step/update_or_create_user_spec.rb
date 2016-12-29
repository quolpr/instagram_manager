require 'rails_helper'

RSpec.describe Session::Step::UpdateOrCreateUser do
  subject { Session::Step::UpdateOrCreateUser.(options) }

  before do
    allow(User::Operation::UpdateOrCreate).to receive(:call).and_return(
      Trailblazer::Operation::Result.new(true, 'model' => model)
    )
  end
  let(:model) { double }
  let(:options) { { 'user_params' => {} } }

  it 'calls UpdateOrCreate operation' do
    expect(User::Operation::UpdateOrCreate).to receive(:call).with(
      options['user_params']
    )
    subject
  end

  it 'sets operation' do
    expect { subject }.to change { options['user'] }.to(model)
  end

  it { is_expected.to be true }
end
