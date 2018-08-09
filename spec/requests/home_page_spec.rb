# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home Page', type: :request do
  context 'html' do
    it 'loads the homepage' do
      get '/'
      expect(response).to have_http_status(200)
    end
  end
end
