require 'rails_helper'

RSpec.describe 'Home Page', type: :request do
  it 'passes' do 
    get '/'
    expect(response).to be_success
  end
end
