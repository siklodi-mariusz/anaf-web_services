# frozen_string_literal: true

RSpec.describe ANAF do
  describe '.get_company' do
    let(:company_cui) { 123_456 }

    subject { described_class.get_company(company_cui) }

    context 'when company is found' do
      before do
        stub_successful_vat_registry_request(company_cui)
      end

      it { is_expected.to eq({ 'cui' => company_cui }) }
    end

    context 'when company is not found' do
      before do
        stub_failed_vat_registry_request(company_cui)
      end

      it { is_expected.to be_nil }
    end
  end
end
