# frozen_string_literal: true

class AddPathVerbIndexToEndpoint < ActiveRecord::Migration[7.0]
  def change
    add_index :endpoints, %i[path verb], unique: true
  end
end
