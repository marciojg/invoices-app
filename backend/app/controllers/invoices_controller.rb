# frozen_string_literal: true

class InvoicesController < ApplicationController
  def index
    data = Invoices::List::Process.call(params:).data

    render json: { data: }
  end

  def show
    result = Invoices::Show::Process.call(id: params[:id])

    if result.success?
      render json: { data: result.data }
    else
      render json: { data: result.data }, status: :not_found
    end
  end

  def create
    result = Invoices::Creation::Process.call(params:)

    if result.success?
      render json: { data: result.data }, status: :created
    else
      render json: { data: result.data }, status: :unprocessable_entity
    end
  end
end
