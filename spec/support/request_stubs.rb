# frozen_string_literal: true

module RequestStubs
  def stub_successful_vat_registry_request(id)
    stub_request(:post, vat_registry_api_endpoint).with(
      body: [{ cui: id, data: Date.today.to_s }].to_json,
      headers: { 'Content-Type' => 'application/json' }
    ).to_return(
      status: 200,
      body: response_body(code: 200, message: 'SUCCESS', found: [{ cui: id }]).to_json
    )
  end

  def stub_failed_vat_registry_request(id)
    stub_request(:post, vat_registry_api_endpoint).with(
      body: [{ cui: id, data: Date.today.to_s }].to_json,
      headers: { 'Content-Type' => 'application/json' }
    ).to_return(
      status: 200,
      body: response_body(code: 501, message: 'ERROR').to_json
    )
  end

  private

    def vat_registry_api_endpoint
      "#{ANAF::WebServices::VatRegistry::BASE_URL}#{ANAF::WebServices::VatRegistry::PATH}"
    end

    def response_body(code:, message:, found: [])
      {
        cod: code,
        message: message,
        found: found,
        not_found: []
      }
    end
end
