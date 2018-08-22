FactoryBot.define do
  factory :client_document do
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'test_files', 'test.png')) }
    workflow_state 'pending'
    document_kind
    order
  end
end