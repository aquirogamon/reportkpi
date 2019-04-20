Rails.application.routes.draw do
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :iprannet_qosingressinterfaces
  resources :iprannet_qosegressinterfaces
  resources :ipranaccess_qosingressinterfaces
  resources :ipranaccess_qosegressinterfaces
  resources :manager_sessions
  resources :internet_links
  resources :ipranedge_interfaces
  resources :statusnokia_ports
  resources :accediandevices
  resources :sevone_sessions
  resources :manager_sessions do
    match :search, to: 'manager_sessions#index', via: :post, on: :collection
  end
  resources :statusnokia_ports do
    match :search, to: 'statusnokia_ports#index', via: :post, on: :collection
  end
  resources :ipranaccess_qosegressinterfaces do
    match :search, to: 'ipranaccess_qosegressinterfaces#index', via: :post, on: :collection
  end
  resources :ipranaccess_qosingressinterfaces do
    match :search, to: 'ipranaccess_qosingressinterfaces#index', via: :post, on: :collection
  end
  resources :iprannet_qosegressinterfaces do
    match :search, to: 'iprannet_qosegressinterfaces#index', via: :post, on: :collection
  end
  resources :iprannet_qosingressinterfaces do
    match :search, to: 'iprannet_qosingressinterfaces#index', via: :post, on: :collection
  end
  resources :cpecac_interfaces do
    collection do
      delete 'destroy_multiple'
    end
  end
  resources :preagg_interfaces do
    collection do
      delete 'destroy_multiple'
    end
  end
  resources :core_interfaces do
    collection do
      delete 'destroy_multiple'
    end
  end
  resources :internet_interfaces do
    collection do
      delete 'destroy_multiple'
    end
  end

  get 'samreports/show'
  get 'ppmreports/show'
  get 'manager_createsessions/show'
  
  devise_for :users

  devise_scope :user do
    root :to => 'devise/sessions#new'
  end
  
  get '/dashboard' => 'welcome#index'

  resource :ppmreports, only: [:show] do
  end

  resource :samreport, only: [:show] do
  end
  
  resource :summaryreports, only: [:show] do
    resource :utilizationreports, only: [:show]
    resource :utilizationaccessreports, only: [:show]
    resource :utilizationcachereports, only: [:show]
  end

  resources :manager_sessions do
    collection do
      post 'restart_session_id'
    end
  end

end
