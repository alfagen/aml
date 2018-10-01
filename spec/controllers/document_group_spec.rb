require 'rails_helper'

RSpec.describe Amlapp::DocumentGroupsController, type: :controller do
  let(:aml_status) { create(:aml_status) }
  let(:aml_document_group) { create(:aml_document_group) }
  let(:administrator) { create(:aml_operator, role: 'administrator') }

  context 'actions' do
    before { login_user(administrator) }

    it '#create' do
      post 'create', params: { document_group: { title: 'title', details: 'detils', position: 1 } }
      expect(response).to be_redirect
    end

    it '#index' do
      get :index
      expect(response).to be_successful
    end
  end
end
