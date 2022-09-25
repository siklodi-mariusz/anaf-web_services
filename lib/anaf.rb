# frozen_string_literal: true

require_relative 'anaf/web_services/version'
require_relative 'anaf/web_services'

module ANAF # :nodoc:
  class << self
    def get_company(cui)
      WebServices::VatRegistry.new([cui]).call.first
    rescue WebServices::InvalidRequest
      nil
    end

    def get_companies(cuis)
      WebServices::VatRegistry.new(cuis).call.first
    rescue WebServices::InvalidRequest
      []
    end
  end
end
