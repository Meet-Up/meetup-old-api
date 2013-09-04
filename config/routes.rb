MeetupApi::Application.routes.draw do

  match 'auth/get_token', to: 'auth#get_token', via: [:post]
  match 'auth/confirm_user', to: 'auth#confirm_user', via: [:post]
  match 'auth/check', to: 'auth#check', via: [:get]

  match 'scheduler' => 'scheduler#respondToToken', via: [:get]
  match 'newTime' => 'scheduler#postNewTimes', via: [:get]

  match 'scheduler', to: 'scheduler#respondToToken'

  #match 'newTime' => 'scheduler#postNewTimes'
  post 'newTime' => 'scheduler#newTimes'

  resources :events
  resources :possible_dates

end
