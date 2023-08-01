# frozen_string_literal: true

module Endpoints
  class Destroy
    def initialize(id:)
      @id = id
    end

    def call!
      endpoint.destroy!
      endpoint
    end

    private

    def endpoint
      @endpoint ||= Endpoint.find(@id)
    end
  end
end
