Rails.application.routes.draw do
  namespace 'v1' do
    get 'areas', to: 'areas#index'
    get 'areas/contain', to: 'areas#contain'
  end
end
