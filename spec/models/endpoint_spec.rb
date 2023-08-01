# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Endpoint do
  describe 'validations' do
    before { FactoryBot.build(:endpoint) }
    it { should validate_presence_of(:verb) }
    it { should validate_presence_of(:path) }
    it { should validate_presence_of(:code) }
  end
end
