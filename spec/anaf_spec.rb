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

  describe '.get_balance_sheet' do
    let(:company_cui) { 123_456 }
    let(:year) { 2019 }
    let(:service) { instance_double('ANAF::WebServices::BalanceSheet', call: service_response) }
    let(:service_response) { { result: true } }

    subject { described_class.get_balance_sheet(company_cui, year) }

    it 'calls balance sheet service' do
      expect(ANAF::WebServices::BalanceSheet).to receive(:new).with(company_cui, year).and_return(service)
      expect(subject).to eq(service_response)
    end
  end
end
