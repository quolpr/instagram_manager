require 'rails_helper'

RSpec.describe Token::Operation::Encode do
  subject { described_class.(data)['result'] }
  let(:data) { { t: 0 } }
  let(:secret) { '12345' }

  let(:jwt_token) { 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0IjowfQ.hm_Qw53wYSXVpIHeHrVK54tAvj_k5DI5wEgxOJswomE' }

  it 'return new JWT token' do
    expect(subject).to eq(jwt_token)
  end
end
