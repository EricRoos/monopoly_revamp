# frozen_string_literal: true

require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the InvitationsHelper. For example:
#
# describe InvitationsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe InvitationsHelper, type: :helper do
  describe '#display_invite_number' do
    context 'more than one invite' do
      it 'displays the right message' do
        expect(helper.display_invite_number(5)).to eq('(5) Invitations')
      end
    end

    context 'one invite' do
      it 'displays the right message' do
        expect(helper.display_invite_number(1)).to eq('(1) Invitation')
      end
    end
  end
end
