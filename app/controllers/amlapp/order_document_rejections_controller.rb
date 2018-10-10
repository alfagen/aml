require_relative 'application_controller'

module Amlapp
  class OrderDocumentRejectionsController < ApplicationController
    authorize_actions_for :order_document, all_actions: :reject

    helper_method :order_document
    helper_method :available_reject_reasons

    def new
      render :new, locals: { order_document: order_document, reason: available_reject_reasons('order_document_reason') }
    end

    def create
      authorize_action_for order_document
      order_document.reject! reject_reason: find_reject_reason, details: permitted_params[:reject_reason_details]
      flash.notice = 'Документ отклонен'
      redirect_to order_path(order_document.order)
    rescue Workflow::TransitionHalted, AML::OrderDocument::ClosedOrderError => e
      flash.now.alert = e.message
      render :new, locals: { order_document: order_document }
    end

    private

    def order_document
      @order_document ||= AML::OrderDocument.find params[:order_document_id]
    end

    def find_reject_reason
      id = permitted_params[:aml_reject_reason_id]
      AML::RejectReason.find_by(id: id) || raise("Не найдена причина отклонения #{id}")
    end

    def permitted_params
      params.require(:order_document).permit(:aml_reject_reason_id, :reject_reason_details)
    end
  end
end