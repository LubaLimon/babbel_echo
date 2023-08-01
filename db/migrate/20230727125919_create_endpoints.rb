# frozen_string_literal: true

class CreateEndpoints < ActiveRecord::Migration[7.0]
  def change
    create_table :endpoints do |t|
      t.string :verb
      t.string :path
      t.integer :code
      t.jsonb :headers
      t.string :body
    end
  end
end
