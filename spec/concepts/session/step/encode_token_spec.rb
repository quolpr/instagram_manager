require 'rails_helper'

RSpec.describe Session::Step::EncodeToken do
  subject { described_class.(options) }
  let(:options) { { 'user' => double(id: 1) } }

  it 'encodes token' do
    expect(Token::Operation::Encode).to receive(:call).with(
      user_id: 1
    ).and_call_original
    subject
  end

  it 'sets token as option' do
    subject
    expect(options['token']).to be_a String
  end

  it { is_expected.to be true }
end
