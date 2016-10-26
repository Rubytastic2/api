class Users::SessionsController < Devise::SessionsController

  require 'auth_token'

  # Disable CSRF protection
  #skip_before_action :verify_authenticity_token

  clear_respond_to
  respond_to :json

  def create

    # This is the default behavior from devise - view the sessions controller source:
    # https://github.com/platformatec/devise/blob/master/app/controllers/devise/sessions_controller.rb#L16
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?

    # Here we're deviating from the standard behaviour by issuing our JWT
    # to any JS based client.
    token = AuthToken.encode({ user_id: resource.id })
    respond_with resource do |format|
        #format.html { raise ( 'there should not be a format.hml') }
        format.json { render json: {user: resource.email, token: token } }
    end

    # The default behaviour would have been to simply fire respond_with:
    # respond_with resource, location: after_sign_in_path_for(resource)
  end

end