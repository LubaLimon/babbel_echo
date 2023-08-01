# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Endpoints::Destroy do
  subject(:endpoint) { described_class.new(id: existing_endpoint.id).call! }
  let(:existing_endpoint) { create(:endpoint) }

  it 'destroys endpoint succesfully' do
    expect(endpoint).to be_a Endpoint
  end
end
