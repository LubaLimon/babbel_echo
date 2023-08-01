# frozen_string_literal: true

class MocksController < ApplicationController
  def show
    endpoint = Endpoint.find_by!(path: request.env['REQUEST_URI'], verb: request.method)
    endpoint.headers.each do |header, value|
      response.set_header(header, value)
    end
    render json: endpoint.body, status: endpoint.code
  end
end
