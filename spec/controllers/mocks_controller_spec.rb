# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'mocks controller test', type: :request do
  let(:endpoint) { create(:endpoint, verb: 'GET', body: 'Hello', headers: { "key": 'value' }) }

  before do
    get endpoint.path, as: :json
  end

  it 'shows mock correctly' do
    expect(response.body).to eql 'Hello'
    expect(response.headers).to have_key('key')
    expect(response.headers['key']).to eql 'value'
    expect(response.code).to eq endpoint.code.to_s
  end

  context 'when mock does not exist' do
    before do
      get '/nonexisting', as: :json
    end

    it 'returns a not found error' do
      expect(response.code).to eq '404'
      expect(JSON.parse(response.body)).to have_key 'errors'
    end
  end
end
