# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HeadersValidator do
  subject do
    Struct.new(:headers) do
      include ActiveModel::Validations

      validates :headers, headers: true
    end.new(headers).valid?
  end

  [
    { "allowed": 'headers' },
    { "With-allowed_symbols12": "I allow it!\#@^&" },
    {}
  ].each do |h|
    context "when header is: #{h}" do
      let(:headers) { h }

      it { is_expected.to be(true) }
    end
  end

  [
    {
      "Same": 'upper-case',
      "same": 'lower-case'
    },
    { "Spaces in header": 'Not-allowed' },
    { "Special%-chars#\\": 'Not allowed' },
    ['array']
  ].each do |h|
    context "when header is: #{h}" do
      let(:headers) { h }

      it { is_expected.to be(false) }
    end
  end
end
