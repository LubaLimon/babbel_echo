# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EndpointsController do
  render_views

  describe '#index' do
    subject(:json_response) { JSON.parse(response.body) }

    let(:endpoint1) { create(:endpoint) }
    let(:endpoint2) { create(:endpoint) }

    before do
      endpoint1
      endpoint2
      get :index, as: :json
    end

    it 'lists endpoints' do
      expect(json_response['data'].size).to eql 2
    end
  end

  describe '#show' do
    subject(:json_response) { JSON.parse(response.body) }

    let(:endpoint) { create(:endpoint) }

    before do
      endpoint
      get :show, params: { id: endpoint.id }, as: :json
    end

    it 'shows correct endpoint' do
      expect(json_response['data']['type']).to eql 'endpoints'
      expect(json_response['data']['id']).to eql endpoint.id.to_s
      expect(json_response['data']['attributes']['verb']).to eql endpoint.verb
      expect(json_response['data']['attributes']['path']).to eql endpoint.path
      expect(json_response['data']['attributes']['response']['code']).to eql endpoint.code
      expect(json_response['data']['attributes']['response']['headers']).to eql endpoint.headers
      expect(json_response['data']['attributes']['response']['body']).to eql endpoint.body
    end

    context 'when endpoint does not exist' do
      before do
        get :show, params: { id: 'non_existing' }, as: :json
      end

      it { expect(response.code).to eq '404' }
    end
  end

  describe '#create' do
    subject(:json_response) { JSON.parse(response.body) }

    let(:params) do
      {
        "data": {
          "type": 'endpoints',
          "attributes": {
            "verb": 'POST',
            "path": '/NewPath',
            "response": {
              "code": 300,
              "headers":
                          {
                            "Content-Type": 'application/json'
                          },
              "body": 'Hi second'
            }
          }
        }
      }
    end

    before do
      post :create, params: params, as: :json
    end

    it 'returns created endpoint' do
      expect(json_response['data']['type']).to eql 'endpoints'
      expect(json_response['data']['attributes']['verb']).to eql 'POST'
      expect(json_response['data']['attributes']['path']).to eql '/NewPath'
      expect(json_response['data']['attributes']['response']['code']).to eql 300
      expect(json_response['data']['attributes']['response']['body']).to eql 'Hi second'
    end

    context 'when params are not send' do
      let(:params) do
        {
          "data": []
        }
      end

      it 'returns a bad request error' do
        expect(response.code).to eq '400'
      end
    end

    context 'when verb is an invalid HTTP method' do
      let(:params) do
        {
          "data": {
            "type": 'endpoints',
            "attributes": {
              "verb": 'Invalid',
              "path": '/NewPath',
              "response": {
                "code": 300,
                "headers":
                            {
                              "Content-Type": 'application/json'
                            },
                "body": 'Hi second'
              }
            }
          }
        }
      end

      it 'returns a validation error' do
        expect(response.code).to eq '422'
      end
    end

    context 'when path and verb combination already exists' do
      let(:endpoint) { create(:endpoint, path: '/NewPath', verb: 'POST') }

      let(:params) do
        {
          "data": {
            "type": 'endpoints',
            "attributes": {
              "verb": endpoint.verb,
              "path": endpoint.path,
              "response": {
                "code": 300,
                "headers":
                            {
                              "Content-Type": 'application/json'
                            },
                "body": 'Hi second'
              }
            }
          }
        }
      end

      it 'returns a validation error' do
        expect(response.code).to eq '422'
      end
    end
  end

  describe '#update' do
    subject(:json_response) { JSON.parse(response.body) }

    let(:endpoint) { create(:endpoint) }

    let(:params) do
      {
        "id": endpoint.id,
        "data": {
          "type": 'endpoints',
          "attributes": {
            "verb": 'POST',
            "path": '/NewPath',
            "response": {
              "code": 305,
              "headers":
                          {
                            "Content-Type": 'application/json'
                          },
              "body": 'Hi second'
            }
          }
        }
      }
    end

    before do
      endpoint
      post :update, params: params, as: :json
    end

    it 'shows updated endpoint' do
      expect(json_response['data']['type']).to eql 'endpoints'
      expect(json_response['data']['id']).to eql endpoint.id.to_s
      expect(json_response['data']['attributes']['verb']).to eql 'POST'
      expect(json_response['data']['attributes']['path']).to eql '/NewPath'
      expect(json_response['data']['attributes']['response']['code']).to eql 305
      expect(json_response['data']['attributes']['response']['body']).to eql 'Hi second'
    end

    context 'when params are not send' do
      let(:params) do
        {
          "id": endpoint.id,
          "data": []
        }
      end

      it { expect(response.code).to eq '400' }
    end
  end

  describe '#destroy' do
    let(:endpoint) { create(:endpoint) }

    before do
      endpoint
      post :destroy, params: { id: endpoint.id }, as: :json
    end

    it 'destroys an endpoint' do
      expect(response.code).to eql '204'
    end

    context 'when endpoint does not exist' do
      before do
        get :show, params: { id: 'non_existing' }, as: :json
      end

      it { expect(response.code).to eq '404' }
    end
  end
end
