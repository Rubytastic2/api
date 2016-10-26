Rails.application.routes.draw do

  constraints subdomain: 'api' do
    scope module: 'api' do


      namespace :v1 do

        devise_for :users, controllers: { sessions:       'users/sessions',
                                          registrations:  'users/registrations'
                                        }

        resources :users
        resources :todos
        #mount_devise_token_auth_for 'User', at: 'auth'

      end



    end
  end

end
