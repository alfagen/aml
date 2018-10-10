# frozen_string_literal: true

module Amlapp
  class RejectReasonsController < Amlapp::ApplicationController
    authorize_actions_for AML::RejectReason

    helper_method :kind

    def index
      render :index, locals: { reject_reasons: AML::RejectReason.where(kind: kind).ordered }
    end

    def new
      render :new, locals: { reject_reason: AML::RejectReason.new(permitted_params) }
    end

    def create
      reject_reason = AML::RejectReason.create!(permitted_params)
      flash.notice = "Создана причина ##{reject_reason.id}"
      redirect_to reject_reasons_path(reject_reason: { kind: kind })
    rescue ActiveRecord::RecordInvalid => e
      flash.now.alert = e.message
      render :new, locals: { reject_reason: e.record }
    end

    def edit
      render :edit, locals: { reject_reason: reject_reason }
    end

    def update
      reject_reason.update!(permitted_params)
      flash.notice = 'Причина изменена'
      redirect_to reject_reasons_path(reject_reason: { kind: kind })
    rescue ActiveRecord::RecordInvalid => e
      flash.now.alert = e.message
      render :edit, locals: { reject_reason: e.record }
    end

    def destroy
      kind = reject_reason.kind
      reject_reason.destroy!
      flash.notice = 'Причина удалена'
      redirect_to reject_reasons_path(reject_reason: { kind: kind })
    end

    private

    def reject_reason
      @reject_reason ||= AML::RejectReason.find params[:id]
    end

    def kind
      permitted_params[:kind]
    end

    def permitted_params
      params.fetch(:reject_reason, {}).permit(:title, :kind)
    end
  end
end