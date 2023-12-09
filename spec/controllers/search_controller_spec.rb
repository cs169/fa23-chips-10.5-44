# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe 'GET #search' do
    context 'with a valid address' do
      let(:address) { '123 Main Street' }
      let(:mock_service) { instance_double(Google::Apis::CivicinfoV2::CivicInfoService) }
      let(:mock_result) { instance_double(Google::Apis::CivicinfoV2::RepresentativeInfoResponse) }
      let(:representatives_params) { [{ name: 'John Doe', office: 'Mayor' }] }

      before do
        allow(Google::Apis::CivicinfoV2::CivicInfoService).to receive(:new)
          .and_return(mock_service)
        allow(mock_service).to receive(:key=)
        allow(mock_service).to receive(:representative_info_by_address)
          .with(address: address)
          .and_return(mock_result)
        allow(Representative).to receive(:civic_api_to_representative_params)
          .with(mock_result)
          .and_return(representatives_params)

        get :search, params: { address: address }
      end

      it 'assigns @representatives' do
        expect(assigns(:representatives)).to eq(representatives_params)
      end

      it 'renders the search template' do
        expect(response).to render_template('representatives/search')
      end
    end

    # Additional contexts can be added here for other scenarios, such as invalid addresses
  end
end
