class ApplicationController < ActionController::API
    before_action :configure_permitted_parameters, if: :devise_controller?
    def current_user
      current_user = User.find(jwt_payload['sub'])
    end
    protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[username avatar])
      devise_parameter_sanitizer.permit(:account_update, keys: %i[username avatar])
    end
end
