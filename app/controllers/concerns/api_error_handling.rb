# Turns common exceptions into JSON error responses, so controllers don't
# need their own rescue blocks.
module ApiErrorHandling
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActionController::ParameterMissing, with: :render_bad_request
  end

  private

  def render_not_found(error)
    render json: { error: "#{error.model.underscore.humanize} not found" }, status: :not_found
  end

  def render_bad_request(error)
    render json: { error: error.message }, status: :bad_request
  end

  def render_forbidden(message = "You don't have permission to do this")
    render json: { error: message }, status: :forbidden
  end
end
