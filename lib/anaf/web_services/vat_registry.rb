# frozen_string_literal: true

require 'faraday'

module ANAF
  module WebServices
    class VatRegistry # :nodoc:
      BASE_URL = 'https://webservicesp.anaf.ro'
      PATH = '/PlatitorTvaRest/api/v6/ws/tva'

      attr_reader :ids

      def initialize(ids)
        @ids = ids
      end

      def call
        return [] if request_body.empty?

        response = conn.post(PATH, request_body)
        body = JSON.parse(response.body)

        return body['found'] if response.success? && body['cod'] == 200

        raise InvalidRequest, body['message']
      rescue JSON::ParserError
        raise InvalidRequest, response.body
      end

      def request_body
        @request_body ||= ids.map { |id| { cui: id, data: date } }
      end

      private

      def conn
        @conn ||= Faraday.new(BASE_URL, request: { timeout: 5 }) do |f|
          f.request :json
        end
      end

      def date
        @date ||= Date.today.to_s
      end
    end
  end
end
