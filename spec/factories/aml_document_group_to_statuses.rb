FactoryBot.define do
  factory(:aml_document_group_to_status, class: AML::DocumentGroupToStatus) do
    document_group
    aml_status
  end
end
