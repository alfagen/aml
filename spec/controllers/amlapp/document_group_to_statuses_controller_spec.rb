require 'rails_helper'

RSpec.describe Amlapp::DocumentGroupToStatusesController, type: :controller do
  let(:aml_status) { create(:aml_status) }
  let(:aml_document_group) { create(:aml_document_group) }
  let!(:aml_operator) { create(:aml_operator, :administrator) }
  let(:user) { create(:user, aml_operator_id: aml_operator.id) }

  describe 'actions' do
    before { login_user(user) }

    context '#create' do
      it 'should create' do
        post 'create', params: { aml_document_group_to_status: { aml_status_id: aml_status.id, aml_document_group_id: aml_document_group.id } }
        expect(response).to be_redirect
      end
    end
  end
end
