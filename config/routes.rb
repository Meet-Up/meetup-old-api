MeetupApi::Application.routes.draw do
  root to: 'main#index'

  match 'auth/get_token', to: 'auth#get_token', via: [:post]
  match 'auth/confirm_user', to: 'auth#confirm_user', via: [:post]
  match 'auth/check', to: 'auth#check', via: [:get]

  match 'searchs/event_detail', to: 'searchs#event_detail', via: [:post]
  match 'searchs/events', to: 'searchs#events', via: [:post]

  resources :events do
    member do
      post 'update_possible_dates'
      get 'participants'
    end
    collection do
      get 'schedule'
    end
  end
  resources :possible_dates

  match '/*path' => 'application#cors_preflight_check', via: :options
end
