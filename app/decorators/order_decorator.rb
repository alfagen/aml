class OrderDecorator < ApplicationDecorator
  delegate_all

  def name
    object.name.presence || none
  end

  def operator
    object.operator&.name
  end

  def client
    h.link_to object.client, h.client_path(object.client)
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
end
