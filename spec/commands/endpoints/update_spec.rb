# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Endpoints::Update do
  subject(:endpoint) { described_class.new(id: id, endpoint_params: params).call! }
  let(:existing_endpoint) { create(:endpoint) }
  let(:id) { existing_endpoint.id }

  let(:params) do
    {
      "verb": 'GET',
      "path": '/NewPath',
      "code": 200,
      "headers":
                        {
                          "Content-Type": 'application/json'
                        },
      "body": 'Hi second'
    }
  end
  it 'updates endpoint succesfully' do
    expect(endpoint).to be_a Endpoint
    expect(endpoint.path).to eq '/NewPath'
  end

  context 'when record does not exist' do
    let(:id) { existing_endpoint.id + 1 }

    it 'returns error' do
      expect { endpoint }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
