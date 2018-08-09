# frozen_string_literal: true

class AddDeclinedToInvitation < ActiveRecord::Migration[5.2]
  def change
    add_column :invitations, :declined, :boolean
  end
end
