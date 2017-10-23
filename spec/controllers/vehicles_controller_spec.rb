require 'rails_helper'

RSpec.describe VehiclesController, type: :controller do
  describe 'POST #create' do
    let(:valid_attributes) { { id: 'd891bd56-d3d9-4a42-bb75-32545747f495' } }

    context 'when the request is valid' do
      it 'creates a vehicle' do
        expect { post :create, params: valid_attributes }.to change(Vehicle, :count).by(1)
      end

      it 'returns status code 204' do
        post :create, params: valid_attributes
        expect(response).to have_http_status(204)
      end

      it 'returns empty response body' do
        post :create, params: valid_attributes
        expect(response.body).to be_empty
      end
    end
  end
end