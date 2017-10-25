require 'rails_helper'

RSpec.describe VehiclesController, type: :controller do
  describe 'POST #create' do
    let(:valid_attributes) do
      {
        id: 'd891bd56-d3d9-4a42-bb75-32545747f495'
      }
    end

    it { should route(:post, '/vehicles').to(action: :create) }

    context 'when the request is valid' do
      it 'creates a vehicle' do
        expect { post :create, params: valid_attributes }.to change(Vehicle, :count).by(1)
        expect(Vehicle.last.moving).to be_truthy
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

    context 'when a vehicle with same uuid already exists' do
      let!(:vehicle) { create(:vehicle, uuid: 'd891bd56-d3d9-4a42-bb75-32545747f495', moving: false) }

      it 'creates a vehicle' do
        expect(Vehicle.last.moving).to be_falsy
        expect { post :create, params: valid_attributes }.to change(Vehicle, :count).by(0)
        expect(Vehicle.last.moving).to be_truthy
      end
    end
  end

  describe 'POST #destroy' do
    let(:vehicle_uuid) { 'd891bd56-d3d9-4a42-bb75-32545747f495' }
    let!(:vehicle) { create(:vehicle, uuid: vehicle_uuid, moving: true) }
    let(:valid_attributes) do
      {
        id: 'd891bd56-d3d9-4a42-bb75-32545747f495'
      }
    end

    it { should route(:delete, "/vehicles/#{vehicle_uuid}").to(action: :destroy, id: 'd891bd56-d3d9-4a42-bb75-32545747f495') }

    context 'when the request is valid' do
      it 'de-registers a vehicle by setting moving to false' do
        expect(Vehicle.last.moving).to be_truthy
        expect { delete :destroy, params: valid_attributes }.to change(Vehicle, :count).by(0)
        expect(Vehicle.last.moving).to be_falsy
      end

      it 'returns status code 204' do
        delete :destroy, params: valid_attributes
        expect(response).to have_http_status(204)
      end

      it 'returns empty response body' do
        delete :destroy, params: valid_attributes
        expect(response.body).to be_empty
      end
    end
  end
end
