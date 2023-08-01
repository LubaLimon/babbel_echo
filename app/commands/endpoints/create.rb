# frozen_string_literal: true

module Endpoints
  class Create
    def initialize(endpoint_params:)
      @endpoint_params = endpoint_params
    end

    def call!
      endpoint.save!
      endpoint
    end

    private

    def endpoint
      @endpoint ||= Endpoint.new(@endpoint_params)
    end
  end
end
