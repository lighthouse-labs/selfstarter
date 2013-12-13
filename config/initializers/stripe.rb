Rails.configuration.stripe = {
  :publishable_key => 'YOUR_STRIPE_PUBLISHABLE_KEY_GOES_HERE',
  :secret_key      => 'YOUR_STRIPE_SECRET_KEY_GOES_HERE'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]