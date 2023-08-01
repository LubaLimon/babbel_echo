# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PathValidator do
  subject do
    Struct.new(:path) do
      include ActiveModel::Validations

      validates :path, path: true
    end.new(path).valid?
  end

  [
    '/simple_path',
    '/path_with',
    '/path_with?param=value',
    '/rfc3968symbols?;=:@?%]()*+,'
  ].each do |p|
    context "when path is: #{p}" do
      let(:path) { p }

      it { is_expected.to be(true) }
    end
  end

  [
    'no_leading_slash',
    '/weird_sąmbołs',
    '/spaces in between'
  ].each do |p|
    context "when path is: #{p}" do
      let(:path) { p }

      it { is_expected.to be(false) }
    end
  end
end
