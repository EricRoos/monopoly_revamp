# frozen_string_literal: true

require 'rails_helper'

describe 'home/index.html.slim' do
  it 'displays the welcome message' do
    render
    expect(rendered).to have_text('Monopoly')
  end
end
