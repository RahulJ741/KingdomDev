Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'staticpage#index'
  get 'city' => 'staticpage#city'
  get 'privacy' => 'staticpage#privacy'
  get 'lookandbrand' => 'staticpage#lookandbrand'
  get 'whoweare' => 'staticpage#whoweare'
  get 'contact' => 'staticpage#contact'
  get 'sports' => 'staticpage#sports'
  get 'package' => 'staticpage#package'
  get 'event' => 'staticpage#event'
  get 'createownpackage' => 'staticpage#createownpackage'
end
