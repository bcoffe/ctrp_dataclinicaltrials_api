Rails.application.routes.draw do

  namespace 'api' do
      namespace 'v1' do
        resources :data_clinical_trials, except: %w() do
        ### custom URL's
        end
        match "*path", to: 'errors#render_not_found', via: :all
      end
    end

end
