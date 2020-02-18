Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'show_currency_converter' => 'converter#show_currency_converter'
  post 'convert_currency' => 'converter#convert_currency'
end
