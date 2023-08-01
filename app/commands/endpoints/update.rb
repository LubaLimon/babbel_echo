# frozen_string_literal: true

module Endpoints
  class Update
    def initialize(id:, endpoint_params:)
      @id = id
      @endpoint_params = endpoint_params
    end

    def call!
      endpoint.assign_attributes(@endpoint_params)
      endpoint.save!
      endpoint
    end

    private

    def endpoint
      @endpoint ||= Endpoint.find(@id)
    end
  end
end
