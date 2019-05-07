Rails.application.routes.draw do
  namespace :api do
    get "/contacts" => "contacts#contact_action"
    get "/all_contacts" => "contacts#all_contacts_action"
  end
end
