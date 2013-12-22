Feellike::Application.routes.draw do


  devise_for(:users,:controllers => { :sessions => "api::v1::users::sessions" })

  #active admin source 
  #ActiveAdmin.routes(self)
  #devise_for :admin_users, ActiveAdmin::Devise.config
  ##api routes
  namespace :api do
    #require 'sidekiq/web'
    #mount Sidekiq::Web => '/sidekiq'
    api_version({:module => "V1", :header=>{:name => "XAPI", :value=>"application/apps.3fishmedia.com; version=v1"}, :defaults => {:format => :json}, :default => true}) do
    #api_version(:module => "V1", :path => "api/v1", :defaults => {:format => :json}, :default => true) do
      
      #general control
      get 'general/assets/get/:id(.:format)' =>                                                                                             'General/assets#get'
      post 'general/assets/new(.:format)' =>                                                                                                'General/assets#new'
      delete 'general/assets/destroy/:id(.:format)' =>                                                                                      'General/assets#destroy'

      get 'general/pages/get/:id(.:format)' =>                                                                                              'General/pages#get'
      post 'general/pages/new(.:format)' =>                                                                                                 'General/pages#new'
      put 'general/pages/update/:id(.:format)' =>                                                                                           'General/pages#update'
      delete 'general/pages/destroy/:id(.:format)' =>                                                                                       'General/pages#destroy'

      #member control
      post 'members/register/:mobileToken(.:format)' =>                                                                                                  'Users/members#register'
      put 'members/connect/:type/:mobileToken(.:format)' =>                                                                                       'Users/tokens#connectViaSocal'
      put 'members/bind/socal/:type/(.:format)' =>                                                                                     'Users/members#connectSocal'
      put 'members/unbind/socal/:type/(.:format)' =>                                                                                     'Users/members#unConnectSocal'
      get 'members/index(.:format)' =>                                                                                                     'Users/members#index'
      get 'members/get/:id(.:format)' =>                                                                                                    'Users/members#get'
      post 'members/getUsers/:type/:page(.:format)' =>                                                                                                   'Users/members#getUsers'
      get 'members/logout(.:format)' =>                                                                                                     'Users/tokens#destroy'
      post 'members/login/:mobileToken(.:format)' =>                                                                                                     'Users/tokens#create'
      get 'members/profile/:user_id/:type/:page(.:format)' =>                                                                                           'Users/members#getProfile'
      get 'members/familyStatus(.:format)' =>                                                                                               'Users/members#getFamilyStatus'
      get 'members/stats/hasFollowers(.:format)' =>                                                                                               'Users/members#hasFollowUsers'
      get 'members/stats/hasFollowing(.:format)' =>                                                                                               'Users/members#hasFollowingUsers'
      put 'members/addFollower/:id(.:format)' =>                                                                                            'Users/members#addFollow'
      delete 'members/removeFollower/:id(.:format)' =>                                                                                         'Users/members#removeFollow'
      get 'members/stats/totalFollowers(.:format)' =>                                                                                               'Users/members#getTotalFollowers'
      get 'members/stats/totalFollowing(.:format)' =>                                                                                               'Users/members#getTotalFollowing'
      put 'members/notifications/update(.:format)' =>                                                                                                   'Users/members#updateNotifications'
      put 'members/profile/update(.:format)' =>                                                                                                   'Users/members#updateProfile'
      get 'members/getAllMembers/:is_add_following/:userTerm/:page'       =>                                                                                   'Users/members#getAllUsers'
      get 'members/getAllMembers/:is_add_following/:page'           =>                                                                                         'Users/members#getAllUsers'
      get 'members/preference(.:format)' =>                                                                                                             'Users/members#userPrefrences'
      get 'members/report/:user_id(.:format)' =>                                                                                                   'Users/members#send_report'
      get 'members/toggle/private(.:format)'  =>                                                                                                   'Users/members#toggleAsPrivateMode'
      get 'members/facebook/friends'      =>                                                                                                          'Users/members#getFbFriends'
      #feeling control
      get 'feelike/feeling/getall(.:format)' =>                                                                                             'Feelike/feeling#getAll'
      post 'feelike/feeling/new(.:format)' =>                                                                                               'Feelike/feeling#new'
      put 'feelike/feeling/update/:id(.:format)' =>                                                                                         'Feelike/feeling#update'
      delete 'feelike/feeling/destroy/:id(.:format)' =>                                                                                     'Feelike/feeling#destroy'
      post 'members/forget(.:format)' =>                                                                                               'Users/tokens#forgotPassword'
      
      #categories control 
      get 'feelike/categories/getall(.:format)' =>                                                                                          'Feelike/categories#getAll'
      get 'feelike/categories/get/:id(.:format)' =>                                                                                         'Feelike/categories#get'
      post 'feelike/categories/new(.:format)' =>                                                                                            'Feelike/categories#new'
      put 'feelike/categories/update/:id(.:format)' =>                                                                                      'Feelike/categories#update'
      delete 'feelike/categories/destroy/:id(.:format)' =>                                                                                  'Feelike/categories#destroy'

      #posts control 
      get 'feelike/posts/getall/:item_id(.:format)' =>                                                                                      'Feelike/posts#getAll'
      get 'feelike/posts/get/:id(.:format)' =>                                                                                              'Feelike/posts#get'
      post 'feelike/posts/new(.:format)' =>                                                                                                 'Feelike/posts#new'
      post 'feelike/posts/new/image(.:format)' =>                                                                                                 'Feelike/posts#newImage'
      put 'feelike/posts/update/:item_id/:asset_id/:feeling_id/:ue_id(.:format)' =>                                                                                           'Feelike/posts#update'
      delete 'feelike/posts/destroy/:id(.:format)' =>                                                                                       'Feelike/posts#destroy'

      #expirences control
      get 'feelike/exprience/createBlankExpirence(.:format)' =>                                                                       'Feelike/expirences#addBlankExpirence'
      put 'feelike/exprience/update/:ue_id(.:format)' =>                                                                                      'Feelike/expirences#updateExpirence'
      put 'feelike/exprience/follow/add/:ue_id(.:format)' =>                                                                                      'Feelike/expirences#addFollowExpirence'
      delete 'feelike/exprience/follow/delete/:ue_id(.:format)' =>                                                                                      'Feelike/expirences#removeFollowExpirence'
      get 'feelike/exprience/get/:ue_id(.:format)' =>                                                                                         'Feelike/expirences#get'
      get 'feelike/exprience/profile/:ue_id/:type/:page(.:format)' =>                                                                                         'Feelike/expirences#getExpirenceProfile'
      get 'feelike/exprience/profile/:ue_id/:type(.:format)' =>                                                                                         'Feelike/expirences#getExpirenceProfile'
      get 'feelike/exprience/profile/:ue_id(.:format)' =>                                                                                         'Feelike/expirences#getExpirenceProfile'
      put 'feelike/exprience/user/getAll(.:format)' =>                                                                             'Feelike/expirences#getUserExpirences'
      delete 'feelike/exprience/user/delete(:format)' =>                                                                                   'Feelike/expirences#removeExpirence'
      delete 'feelike/exprience/delete/:ue_id(.:format)' =>                                                                                   'Feelike/expirences#deleteUserExpirence'
      get 'feelike/exprience/list/:user_id/:page/:category_id/:exp_search_name(.:format)' =>                                                                                   'Feelike/expirences#getExpirenceFollows'
      get 'feelike/exprience/list/:user_id/:page/:category_id(.:format)' =>                                                                                   'Feelike/expirences#getExpirenceFollows'
      get 'feelike/exprience/list/:user_id/:page(.:format)' =>                                                                                   'Feelike/expirences#getExpirenceFollows'
      get 'feelike/exprience/list/:user_id(.:format)' =>                                                                                   'Feelike/expirences#getExpirenceFollows'
      get 'feelike/exprience/categories/list(.:format)' =>                                                                                   'Feelike/expirences#getExpirenceCategories'
      get 'feelike/exprience/getAll' =>                                                                                                    'Feelike/expirences#getAll'
      get 'feelike/exprience/report/:ue_id' =>                                                                                                   'Feelike/expirences#send_report'
      #expirences Participants control
      get 'feelike/exprience/user/participants/getAll/:ue_id(.:format)' =>                                                                  'Feelike/expirences#getAllParticipants'
      put 'feelike/exprience/user/participants/new/:ue_id(.:format)' =>                                                            'Feelike/expirences#addParticipants'
      delete 'feelike/exprience/user/participants/delete/:ue_id(.:format)' =>                                                      'Feelike/expirences#destroyParticipants'

      #content Items
      get 'feelike/items/search/music/:term/:page(.:format)'=>                                                                             'Feelike/ContentItems#searchByMusic'
      get 'feelike/items/search/music/:feeling_id/:term/:page(.:format)'=>                                                                             'Feelike/ContentItems#searchByMusic'
      get 'feelike/items/search/movie/:term/:page(.:format)'=>                                                                             'Feelike/ContentItems#searchByMovie'
      get 'feelike/items/search/movie/:feeling_id/:term/:page(.:format)'=>                                                                             'Feelike/ContentItems#searchByMovie'
      get 'feelike/items/search/book/:term/:page(.:format)'=>                                                                             'Feelike/ContentItems#searchByBook'
      get 'feelike/items/search/book/:feeling_id/:term/:page(.:format)'=>                                                                             'Feelike/ContentItems#searchByBook'
      get 'feelike/items/feelikes/all/:term/:page/(.:format)' =>                                                                       'Feelike/ContentItems#getRecommendedItems'
      get 'feelike/items/feelikes/all/:page/(.:format)' =>                                                                       'Feelike/ContentItems#getRecommendedItems'
      get 'feelike/items/feelikes/all/popular/:term/:page/(.:format)' =>                                                                       'Feelike/ContentItems#getPopularRecommendedItems'
      get 'feelike/items/feelikes/all/popular/:page/(.:format)' =>                                                                       'Feelike/ContentItems#getPopularRecommendedItems'
      get 'feelike/items/feelikes/music/:term/:page/(.:format)' =>                                                                       'Feelike/ContentItems#getPopularRecommendedByMusic'
      get 'feelike/items/feelikes/music/:page/(.:format)' =>                                                                       'Feelike/ContentItems#getRecommendedByMusic'
      get 'feelike/items/feelikes/music/popular/:term/:page/(.:format)' =>                                                                       'Feelike/ContentItems#getPopularRecommendedByMusic'
      get 'feelike/items/feelikes/music/popular/:page/(.:format)' =>                                                                       'Feelike/ContentItems#getPopularRecommendedByMusic'
      get 'feelike/items/feelikes/movies/:term/:page/(.:format)' =>                                                                       'Feelike/ContentItems#getRecommendedByMovie'
      get 'feelike/items/feelikes/movies/:page/(.:format)' =>                                                                       'Feelike/ContentItems#getRecommendedByMovie'
      get 'feelike/items/feelikes/movies/popular/:term/:page/(.:format)' =>                                                                       'Feelike/ContentItems#getPopularRecommendedByMovie'
      get 'feelike/items/feelikes/movies/popular/:page/(.:format)' =>                                                                       'Feelike/ContentItems#getPopularRecommendedByMovie'
      get 'feelike/items/feelikes/books/:term/:page/(.:format)' =>                                                                       'Feelike/ContentItems#getRecommendedByBook'
      get 'feelike/items/feelikes/books/:page/(.:format)' =>                                                                       'Feelike/ContentItems#getPopularRecommendedByBook'
      get 'feelike/items/feelikes/books/popular/:term/:page/(.:format)' =>                                                                       'Feelike/ContentItems#getPopularRecommendedByBook'
      get 'feelike/items/feelikes/books/popular/:page/(.:format)' =>                                                                       'Feelike/ContentItems#getRecommendedByBook'
      get 'feelike/items/followWall/:page(.:format)'                =>                                                                                          'Feelike/ContentItems#getFollowWall'
      put 'feelike/items/followingMembers/:item_id/:feeling_id/:page(.:format)'=>                                                                             'Feelike/ContentItems#getFeelikeMemebers'
      put 'feelike/items/todoMembers/:item_id/:feeling_id/:page(.:format)'=>                                                                             'Feelike/ContentItems#getTodoMemebers'
      get 'feelike/items/get/:item_id/:feeling_id/:ue_id/(.:format)' =>                                                                            'Feelike/ContentItems#getContentItem'
      get 'feelike/items/get/image/:asset_id/:feeling_id/:ue_id/(.:format)' =>                                                                            'Feelike/ContentItems#getContentItemByImage'
      put 'feelike/items/mark/todo/:item_id/:feeling_id(.:format)' =>                                                                            'Feelike/ContentItems#toggleAsTodo'
      post 'feelike/items/report/:item_id/:feeling_id/:ue_id'     =>                                                                'Feelike/ContentItems#send_report'
      #Notifications Control
      post 'notifications/new/:user_id/:notification_status(.:format)' =>                                                                            'General/Notifications#new'
      get 'notifications/list(.:format)' =>                                                                            'General/Notifications#getAll'
      get 'notifications/total(.:format)' =>                                                                            'General/Notifications#getCount'
     
      #agnet services control
      post 'agent/profiles/updateAgeRang' =>                                                                                                 'general/AgentControl#updateAgeRange'
      
      #general control
    end
  end
  #backend routes
  namespace :backend do
    get 'main/localization/:lang' => 'main#getLocalization'
    get 'main/config/:section' => 'main#getConfig'
    get 'main/index' => 'main#index'
    
    root :to => redirect('main/index')
  end
end
