# frozen_string_literal: true

class Endpoint < ApplicationRecord  
  HTTP_METHODS = %w[GET POST PUT PATCH DELETE COPY HEAD OPTIONS LINK UNLINK PURGE LOCK PROPFIND VIEW].freeze

  validates :verb, presence: true, uniqueness: { scope: :path }, inclusion: HTTP_METHODS
  validates :path, presence: true, path: true
  validates :headers, headers: true
  validates :code, presence: true, numericality: { in: 0..999 }
  before_validation { self.verb = verb&.upcase }
end
