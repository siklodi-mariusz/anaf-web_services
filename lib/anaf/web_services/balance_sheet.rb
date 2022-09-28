# frozen_string_literal: true

require 'faraday'

module ANAF
  module WebServices
    class BalanceSheet # :nodoc:
      BASE_URL = 'https://webservicesp.anaf.ro'
      PATH = '/bilant'

      def initialize(cui, year)
        @cui = cui
        @year = year
      end

      def call
        response = conn.get(PATH, { cui: @cui, an: @year })

        return unless response.success?

        body = JSON.parse(response.body)

        return if body['deni'].nil? || body['deni'].strip.empty?

        body
      end

      private

        def conn
          @conn ||= Faraday.new(BASE_URL, request: { timeout: 5 })
        end
    end
  end
end
