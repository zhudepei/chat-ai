Rails.application.routes.draw do
  scope("api") do
    resources :characters
    resources :faqs
    resources :attachments, only: [:create]
  end

end
