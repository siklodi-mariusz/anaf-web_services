# frozen_string_literal: true

RSpec.describe ANAF do
  describe '.get_company' do
    let(:company_cui) { 123_456 }

    subject { described_class.get_company(company_cui) }

    context 'when company is found' do
      before do
        stub_successful_vat_registry_request([company_cui])
      end

      it { is_expected.to eq({ 'cui' => company_cui }) }
    end

    context 'when company is not found' do
      before do
        stub_failed_vat_registry_request([company_cui])
      end

      it { is_expected.to be_nil }
    end
  end

  describe '.get_companies' do
    let(:company_cuis) { [123_456, 654_321] }

    subject { described_class.get_companies(company_cuis) }

    context 'when companies are found' do
    end

    context 'when companies are not found' do
      let(:company_cuis) { ['not-valid'] }

      before do
        stub_failed_vat_registry_request(company_cuis)
      end

      it { is_expected.to eq([]) }
    end
  end
end
