Dicty11::Application.routes.draw do

	root :to => "home#index", :as => :home

	match '/login' => 'user_sessions#new', :as => :login
	match '/logout' => 'user_sessions#destroy', :as => :logout

	match '/admin' => 'user_sessions#admin', :as => :admin

	#DJM match '/register' => 'registration#new', :as => :register 
	#DJM match '/registrations' => 'registration#view', :as => :registrations

	match '/payment' => 'registration#payment', :as => :payment_redirect
	# match '/users/:id', :to => 'users#show', :as => :user

	resources :user_sessions
	resources :users
	resources :registration
	resources :abstracts

	resources :users do
		resources :abstracts
	end

	# resources :users do
	#   resources :registration
	# end

	match '/agenda' => 'home#agenda', :as => :agenda
	match '/transport' => 'home#transport', :as => :transport
	match '/sponsors' => 'home#sponsors', :as => :sponsors
	match '/regitration' => 'home#registration', :as => :registration #DJM


end
