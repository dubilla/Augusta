class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery

  rescue_from Mailgun::Error, Railgun::Error, with: :mail_delivery_failed

  private

  def mail_delivery_failed(error)
    logger.error("Mail delivery failed: #{error.class}: #{error.message}")
    redirect_back fallback_location: root_path,
                  alert: "We couldn't send that email. Please try again in a few minutes."
  end
end
