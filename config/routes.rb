Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get 'users/:id', to: 'users#show'
      post 'users', to: 'users#create'
      patch 'users/:id/update', to: 'users#update'
      delete 'users/:id', to: 'users#destroy'

      post 'login', to: 'auth_controller#create'

      post 'users/:id/follow', to: 'user_followers#follow'
      post 'users/:id/unfollow', to: 'user_followers#unfollow'
      get 'users/:id/followers', to: 'user_followers#get_followers'
      get 'users/:id/following', to: 'user_followers#get_followees'

      post 'stories', to: 'stories#create'
      get 'stories', to: 'stories#index'
      get 'stories/:id', to: 'stories#show'
      patch 'stories/:id', to: 'stories#update'
      post 'stories/:id/like', to: 'stories#like'
      delete 'stories/:id', to: 'stories#destroy'
      get 'stories/:id/comments', to: 'comments#get_all'

      get 'stories/tagged/:tag', to: 'tags#get_tagged_story_ids'
      post 'stories/:id/tag', to: 'tags#tag_story'
      delete 'stories/:id/tag/:tag', to: 'tags#delete_tag'

      post 'comments', to: 'comments#create'
      delete 'comments/:id', to: 'comments#destroy'

    end
  end
end
