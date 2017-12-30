Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get 'users/:id', to: 'users#show'
      post 'users', to: 'users#create'
      patch 'users/:id/update', to: 'users#update'
      delete 'users/:id', to: 'users#destroy'

      post 'users/:id/follow', to: 'user_followers#follow'
      post 'users/:id/unfollow', to: 'user_followers#unfollow'
      post 'users/:id/followers', to: 'user_followers#get_followers'
      post 'users/:id/followees', to: 'user_followers#get_followees'

      post 'comments', to: 'comments#create'
      delete 'comments/:id', to: 'comments#destroy'

      post 'stories/:id/comments', to: 'comments#get_all'
      post 'stories', to: 'stories#create'
      get 'stories', to: 'stories#index'
      get 'stories/:id', to: 'stories#show'
      patch 'stories/:id', to: 'stories#update'
      post 'stories/:id/like', to: 'stories#like'
      delete 'stories/:id', to: 'stories#destroy'

      post 'stories/tagged', to: 'tags#get_tagged_story_ids'  #needs to be changed to url query
      post 'stories/:id/tag', to: 'tags#tag_story'

    end
  end
end
