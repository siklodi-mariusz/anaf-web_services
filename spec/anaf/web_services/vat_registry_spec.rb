# frozen_string_literal: true

RSpec.describe ANAF::WebServices::VatRegistry do
  describe '#call' do
    let(:ids) { [1] }
    let(:api_endpoint) { "#{described_class::BASE_URL}#{described_class::PATH}" }

    subject { described_class.new(ids).call }

    context 'when request body is empty' do
      let(:ids) { [] }

      it 'does not make API call' do
        subject
        expect(a_request(:post, api_endpoint)).to_not have_been_made
      end
    end

    context 'when request body is not empty' do
      before do
        stub_successful_vat_registry_request([1])
      end

      it 'calls API' do
        subject
        expect(
          a_request(:post, api_endpoint).with(
            body: [{ cui: 1, data: Date.today.to_s }].to_json
          )
        ).to have_been_made.once
      end
    end

    context 'when response is unsuccessful with error message' do
      before do
        stub_failed_vat_registry_request(ids)
      end

      it 'raises error with message' do
        expect { subject }.to raise_error(ANAF::WebServices::InvalidRequest, 'ERROR')
      end
    end

    context 'when response is not JSON' do
      let(:html_response) { '<html><head><title>Request Rejected</title></head><body>Request Failed</body></html>' }

      before do
        stub_request(:post, api_endpoint).to_return(
          body: html_response
        )
      end

      it 'raises error with response body' do
        expect { subject }.to raise_error(ANAF::WebServices::InvalidRequest, html_response)
      end
    end

    context 'when request times out' do
      before do
        stub_request(:post, api_endpoint).to_raise(Faraday::TimeoutError)
      end

      it 'raises TimeoutError' do
        expect { subject }.to raise_error(ANAF::WebServices::TimeoutError)
      end
    end

    context 'when request connection fails' do
      before do
        stub_request(:post, api_endpoint).to_raise(Faraday::ConnectionFailed)
      end

      it 'raises TimeoutError' do
        expect { subject }.to raise_error(ANAF::WebServices::TimeoutError)
      end
    end
  end

  describe '#request_body' do
    subject { described_class.new(ids).request_body }

    context 'when ids array is empty' do
      let(:ids) { [] }

      it { is_expected.to eq([]) }
    end

    context 'when ids array is not empty' do
      let(:ids) { [1, 2, 3] }
      let(:date) { Date.today.to_s }
      let(:expected_return) do
        [
          { cui: 1, data: date },
          { cui: 2, data: date },
          { cui: 3, data: date }
        ]
      end

      it { is_expected.to eq(expected_return) }
    end
  end
end
