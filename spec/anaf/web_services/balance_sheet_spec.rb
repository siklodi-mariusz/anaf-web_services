# frozen_string_literal: true

RSpec.describe ANAF::WebServices::BalanceSheet do
  describe '#call' do
    let(:api_endpoint) { "#{described_class::BASE_URL}#{described_class::PATH}" }
    let(:cui) { 123_456 }
    let(:year) { 2019 }
    let(:response_body) { { 'deni' => 'Test' } }

    subject { described_class.new(cui, year).call }

    context 'when response is successful' do
      before do
        stub_request(:get, api_endpoint).with(query: { cui: cui, an: year }).to_return(
          status: 200,
          body: response_body.to_json
        )
      end

      it 'returns response body' do
        expect(subject).to eq(response_body)
        expect(a_request(:get, api_endpoint).with(query: { cui: cui, an: year })).to have_been_made
      end

      context 'and response body is invalid' do
        let(:response_body) { { 'deni' => '' } }

        it 'returns nil' do
          expect(subject).to eq(nil)
          expect(a_request(:get, api_endpoint).with(query: { cui: cui, an: year })).to have_been_made
        end
      end
    end

    context 'when response is unsuccessful' do
      before do
        stub_request(:get, api_endpoint).with(query: { cui: cui, an: year }).to_return(status: 400)
      end

      it 'returns nil' do
        expect(subject).to eq(nil)
        expect(a_request(:get, api_endpoint).with(query: { cui: cui, an: year })).to have_been_made
      end
    end
  end
end
