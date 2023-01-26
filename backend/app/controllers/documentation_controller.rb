# frozen_string_literal: true

class DocumentationController < ActionController::Base
  def api_doc
    render file: Rails.root.join('public', 'doc', 'openapi.html')
  end
end
