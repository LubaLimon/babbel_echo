# frozen_string_literal: true

class EndpointsController < ApplicationController
  def index
    @endpoints = Endpoint.all
  end

  def show
    @endpoint = Endpoint.find(params[:id])
  end

  def create
    @endpoint = Endpoints::Create.new(endpoint_params: endpoint_params).call!
    render 'show', status: :created
  end

  def update
    @endpoint = Endpoints::Update.new(id: params['id'], endpoint_params: endpoint_params).call!
    render 'show', status: :ok
  end

  def destroy
    @endpoint = Endpoints::Destroy.new(id: params['id']).call!
    render json: nil, status: :no_content
  end

  private

  def endpoint_params
    request_params = params.require('data').require('attributes').permit('path', 'verb')
    response_params = params.require('data').require('attributes').require('response').permit!
    request_params.merge(response_params)
  end
end
