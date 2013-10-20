class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def stripe_connect
    auth_hash = request.env['omniauth.auth']

    if auth_hash[:error].present?
      logger.fatal [auth_hash[:error], auth_hash[:error_description]].join
      generic_error and return
    end

    # @TODO Add CSRF protection

    # Very unlikely, but params[:state] could contain an invalid user_id
  begin
    user = User.find(params[:state])
  rescue ActiveRecord::RecordNotFound => error
    logger.error error
    generic_error and return
  end

    # User exists and does not have a StripeAccount yet
    if user && user.stripe_account.blank?
      stripe_account = StripeAccount.new do |account|
        account.user            = user
        account.access_token    = auth_hash.credentials[:token]
        account.publishable_key = auth_hash.extra[:raw_info][:stripe_publishable_key]
        account.stripe_user_id  = auth_hash.extra[:raw_info][:stripe_user_id]
      end

      if stripe_account.save
        redirect_to root_path, notice: 'Your Stripe account has been successfully connected'
      else
        # Very unlikely, but the auth_hash could not provide required informations
        # for a valid StripeAccount to be created
        logger.error stripe_account.errors.full_messages.to_s
        generic_error
      end
    else
      redirect_to root_path, notice: "A Stripe account is already linked to your account"
    end
  end


  private

  def generic_error
    redirect_to root_path, notice: 'Something has went wrong and we are currently investigating the issue'
  end
end
