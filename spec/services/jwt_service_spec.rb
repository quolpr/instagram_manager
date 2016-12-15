require 'rails_helper'

RSpec.describe JwtService, type: :service do
  let(:payload) { { 'test' => true } }
  let(:secret) { '12345' }

  describe '#encode' do
    subject { JwtService.encode(payload) }

    it 'encodes payload' do
      expect(JWT).to receive(:encode).with(payload, secret, 'HS256')
      subject
    end
  end

  describe '#decode' do
    subject { JwtService.decode(JwtService.encode(payload)) }

    it 'decodes payload' do
      expect(subject).to eq payload
    end
  end
end
