Rails.application.routes.draw do
  namespace 'v1' do
    get 'areas', to: 'areas#index'
    get 'areas/contain', to: 'areas#contain'
  end

  match "/", to: "application#unknown_route", via: :all
  match "*path", to: "application#unknown_route", via: :all
end
