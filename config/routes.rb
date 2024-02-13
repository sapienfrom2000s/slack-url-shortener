Rails.application.routes.draw do
  post 'link_shortner/create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount Api => '/'
end
