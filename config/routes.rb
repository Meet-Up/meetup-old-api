MeetupApi::Application.routes.draw do
  root to: 'scheduler#respondToToken'

  match 'auth/get_token', to: 'auth#get_token', via: [:post]
  match 'auth/confirm_user', to: 'auth#confirm_user', via: [:post]
  match 'auth/check', to: 'auth#check', via: [:get]

  match 'scheduler' => 'scheduler#respondToToken', via: [:get]
  match 'newTime' => 'scheduler#postNewTimes', via: [:get]

  match 'scheduler', to: 'scheduler#respondToToken'

  #post 'newTime' => 'scheduler#newTimes'
  post 'newTime' => 'scheduler#post_possible_times'


  match 'searchs/event_detail', to: 'searchs#event_detail', via: [:post]
  match 'searchs/events', to: 'searchs#events', via: [:post]

  resources :events do
    member do
      get 'participants'
    end
  end
  resources :possible_dates

end
