# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Endpoints::Create do
  subject(:endpoint) { described_class.new(endpoint_params: params).call! }

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

  it 'creates endpoint succesfully' do
    expect(endpoint).to be_a Endpoint
  end

  context 'when params are invalid' do
    let(:params) do
      {
        "verb": 'GET',
        "path": '/NewPath',
        "code": 2000,
        "headers":
                      {
                        "Content-Type": 'application/json'
                      },
        "body": 'Hi second'
      }
    end

    it 'returns error' do
      expect { endpoint }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
