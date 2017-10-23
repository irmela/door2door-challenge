require 'rails_helper'

RSpec.describe LocationsController, type: :controller do
  describe 'POST #create' do
    let(:vehicle_uuid) { 'd891bd56-d3d9-4a42-bb75-32545747f495' }
    let!(:vehicle) { create(:vehicle, uuid: vehicle_uuid) }
    let(:valid_attributes) { { lat: 10.0, lng: 20.0, at: '2017-09-01T12:00:00Z', vehicle_uuid: vehicle_uuid } }

    it { should route(:post, "/vehicles/#{vehicle_uuid}/locations").to(action: :create, vehicle_uuid: vehicle_uuid) }

    context 'when the request is valid' do
      it 'creates a location' do
        expect { post :create, params: valid_attributes }.to change(Location, :count).by(1)
        location = Location.last
        expect(location.lat).to eq(10.0)
        expect(location.lng).to eq(20.0)
        expect(location.at).to eq('2017-09-01T12:00:00Z')
        expect(location.vehicle).to eq(vehicle)
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
