# frozen_string_literal: true

class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.references :user, foreign_key: true
      t.references :game, foreign_key: true

      t.timestamps
    end
  end
end
