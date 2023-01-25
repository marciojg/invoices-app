# frozen_string_literal: true

class InvoicesController < ApplicationController
  def index
    data = Invoices::List::Process.call(params:).data

    render json: { data: }
  end
end
