Selfstarter::Application.routes.draw do
  root :to => 'orders#index'
  resources :orders
  match '/preorder'               => 'orders#index', :via => [:get,:post]
  get 'preorder/checkout'
  match '/preorder/share/:uuid'   => 'orders#share', :via => :get
  match '/preorder/ipn'           => 'orders#ipn', :via => :post
  match '/preorder/prefill'       => 'orders#prefill', :via => [:get,:post]
  match '/preorder/postfill'      => 'orders#postfill', :via => [:get,:post]
end
