# frozen_string_literal: true

require_relative 'web_services/vat_registry'
require_relative 'web_services/balance_sheet'

module ANAF
  module WebServices
    class InvalidRequest < StandardError; end
    class TimeoutError < StandardError; end
  end
end
