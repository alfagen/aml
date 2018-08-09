# frozen_string_literal: true

# Стиль active для первоначального открытия на вкладке pending
#
module ClientDocumentHelper
  def style(workflow_state)
    workflow_state == :pending ? :inclusive : :exact
  end
end
