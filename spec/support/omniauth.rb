OmniAuth.config.mock_auth[:stripe_connect] = OmniAuth::AuthHash.new({
  provider: 'stripe_connect',
  uid: '<STRIPE_USER_ID>',
  info: {
    scope: 'read_write',
    livemode: false,
    stripe_publishable_key: '<STRIPE_PUBLISHABLE_KEY>',
  },
  credentials: {
    token: '<STRIPE_ACCESS_TOKEN>',
    expires: false
  },
  extra: {
    raw_info: {
      token_type: 'bearer',
      stripe_user_id: '<STRIPE_USER_ID>',
      scope: 'read_only',
      stripe_publishable_key: '<STRIPE_PUBLISHABLE_KEY>',
      livemode: false
    }
  }
})

OmniAuth.config.mock_auth[:invalid_stripe_connect] = OmniAuth::AuthHash.new({
  error: 'access_denied',
  error_description: 'User denied authorization.'
})
