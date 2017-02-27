Rails.application.routes.draw do


  #resources :data_tests
  #get '/data_tests/:id', to: 'data_tests#index'


  namespace 'api' do
      namespace 'v1' do
        resources :data_clinical_trials, except: %w() do
        #get '/data_clinical_trials/', to: 'data_clinical_trials#index'
        end
        match "*path", to: 'errors#render_not_found', via: :all
      end
    end

end
