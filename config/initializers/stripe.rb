Rails.configuration.stripe = {
  :publishable_key => 'pk_test_Q05sXW6tE78VqDtJcRywPuWb',
  :secret_key      => 'sk_test_KveQsjTuXCSnDuLwshg1Qg3c'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]