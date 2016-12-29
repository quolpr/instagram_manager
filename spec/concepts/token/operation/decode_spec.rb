require 'rails_helper'

RSpec.describe Token::Operation::Decode do
  subject { described_class.(jwt_token)['result'] }
  let(:jwt_token) { 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0IjowfQ.hm_Qw53wYSXVpIHeHrVK54tAvj_k5DI5wEgxOJswomE' }
  let(:result) { { 't' => 0 } }

  it 'returns decoded result' do
    is_expected.to eq result
  end
end
