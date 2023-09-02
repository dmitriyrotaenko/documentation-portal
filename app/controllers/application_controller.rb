class ApplicationController < ActionController::Base
  include Pundit::Authorization
  # before_action :authenticate_user!
  # TODO: remove at the end
  # after_action :verify_authorized

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You're not authorized to perform this action."
    redirect_back_or_to root_path
  end
end
