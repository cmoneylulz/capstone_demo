# == Route Map (Updated 2014-04-03 17:15)
#
#                                          Prefix Verb   URI Pattern                                                                    Controller#Action
#                                         reports GET    /reports(.:format)                                                             reports#index
#                                                 POST   /reports(.:format)                                                             reports#create
#                                      new_report GET    /reports/new(.:format)                                                         reports#new
#                                     edit_report GET    /reports/:id/edit(.:format)                                                    reports#edit
#                                          report GET    /reports/:id(.:format)                                                         reports#show
#                                                 PATCH  /reports/:id(.:format)                                                         reports#update
#                                                 PUT    /reports/:id(.:format)                                                         reports#update
#                                                 DELETE /reports/:id(.:format)                                                         reports#destroy
#                                            maps GET    /maps(.:format)                                                                maps#index
#                                                 POST   /maps(.:format)                                                                maps#create
#                                         new_map GET    /maps/new(.:format)                                                            maps#new
#                                        edit_map GET    /maps/:id/edit(.:format)                                                       maps#edit
#                                             map GET    /maps/:id(.:format)                                                            maps#show
#                                                 PATCH  /maps/:id(.:format)                                                            maps#update
#                                                 PUT    /maps/:id(.:format)                                                            maps#update
#                                                 DELETE /maps/:id(.:format)                                                            maps#destroy
#                                       maps_main GET    /maps/main(.:format)                                                           maps#main
#                                            root GET    /                                                                              maps#main
#                                         contact GET    /static_pages/contact(.:format)                                                static_pages#contact
#                                           about GET    /static_pages/about(.:format)                                                  static_pages#about
#           update_multiple_admin_interest_points PUT    /admin/interest_points/update_multiple(.:format)                               admin/interest_points#update_multiple
#                    approve_admin_interest_point PUT    /admin/interest_points/:id/approve(.:format)                                   admin/interest_points#approve
#                  unapprove_admin_interest_point PUT    /admin/interest_points/:id/unapprove(.:format)                                 admin/interest_points#unapprove
#                           admin_interest_points GET    /admin/interest_points(.:format)                                               admin/interest_points#index
#                            admin_interest_point GET    /admin/interest_points/:id(.:format)                                           admin/interest_points#show
#                    update_multiple_admin_images PUT    /admin/images/update_multiple(.:format)                                        admin/images#update_multiple
#                             approve_admin_image PUT    /admin/images/:id/approve(.:format)                                            admin/images#approve
#                           unapprove_admin_image PUT    /admin/images/:id/unapprove(.:format)                                          admin/images#unapprove
#                                    admin_images GET    /admin/images(.:format)                                                        admin/images#index
#                                     admin_image GET    /admin/images/:id(.:format)                                                    admin/images#show
#                      admin_update_default_image PUT    /admin/update_default_image(.:format)                                          admin/interest_points#update_default_image
#              active_contributor_interest_points GET    /contributor/interest_points/active(.:format)                                  contributor/interest_points#active
#             pending_contributor_interest_points GET    /contributor/interest_points/pending(.:format)                                 contributor/interest_points#pending
# contributor_interest_point_update_default_image PUT    /contributor/interest_points/:interest_point_id/update_default_image(.:format) contributor/interest_points#update_default_image
#                     contributor_interest_points GET    /contributor/interest_points(.:format)                                         contributor/interest_points#index
#                 edit_contributor_interest_point GET    /contributor/interest_points/:id/edit(.:format)                                contributor/interest_points#edit
#                         interest_point_comments GET    /interest_points/:interest_point_id/comments(.:format)                         comments#index
#                                                 POST   /interest_points/:interest_point_id/comments(.:format)                         comments#create
#                      new_interest_point_comment GET    /interest_points/:interest_point_id/comments/new(.:format)                     comments#new
#                           interest_point_rating PATCH  /interest_points/:interest_point_id/ratings/:id(.:format)                      ratings#update
#                                                 PUT    /interest_points/:interest_point_id/ratings/:id(.:format)                      ratings#update
#                           interest_point_images GET    /interest_points/:interest_point_id/images(.:format)                           images#index
#                                                 POST   /interest_points/:interest_point_id/images(.:format)                           images#create
#                        new_interest_point_image GET    /interest_points/:interest_point_id/images/new(.:format)                       images#new
#                            interest_point_image DELETE /interest_points/:interest_point_id/images/:id(.:format)                       images#destroy
#                                 interest_points GET    /interest_points(.:format)                                                     interest_points#index
#                                                 POST   /interest_points(.:format)                                                     interest_points#create
#                              new_interest_point GET    /interest_points/new(.:format)                                                 interest_points#new
#                             edit_interest_point GET    /interest_points/:id/edit(.:format)                                            interest_points#edit
#                                  interest_point GET    /interest_points/:id(.:format)                                                 interest_points#show
#                                                 PATCH  /interest_points/:id(.:format)                                                 interest_points#update
#                                                 PUT    /interest_points/:id(.:format)                                                 interest_points#update
#                                                 DELETE /interest_points/:id(.:format)                                                 interest_points#destroy
#                                         artists GET    /artists(.:format)                                                             artists#index
#                                                 POST   /artists(.:format)                                                             artists#create
#                                      new_artist GET    /artists/new(.:format)                                                         artists#new
#                                     edit_artist GET    /artists/:id/edit(.:format)                                                    artists#edit
#                                          artist GET    /artists/:id(.:format)                                                         artists#show
#                                                 PATCH  /artists/:id(.:format)                                                         artists#update
#                                                 PUT    /artists/:id(.:format)                                                         artists#update
#                                                 DELETE /artists/:id(.:format)                                                         artists#destroy
#                               category_comments GET    /categories/:category_id/comments(.:format)                                    comments#index
#                                                 POST   /categories/:category_id/comments(.:format)                                    comments#create
#                            new_category_comment GET    /categories/:category_id/comments/new(.:format)                                comments#new
#                                      categories GET    /categories(.:format)                                                          categories#index
#                                                 POST   /categories(.:format)                                                          categories#create
#                                    new_category GET    /categories/new(.:format)                                                      categories#new
#                                   edit_category GET    /categories/:id/edit(.:format)                                                 categories#edit
#                                        category GET    /categories/:id(.:format)                                                      categories#show
#                                                 PATCH  /categories/:id(.:format)                                                      categories#update
#                                                 PUT    /categories/:id(.:format)                                                      categories#update
#                                                 DELETE /categories/:id(.:format)                                                      categories#destroy
#                               reported_comments GET    /reported_comments(.:format)                                                   comments#reported
#                                           users GET    /users(.:format)                                                               users#index
#                                                 POST   /users(.:format)                                                               users#create
#                                        new_user GET    /users/new(.:format)                                                           users#new
#                                       edit_user GET    /users/:id/edit(.:format)                                                      users#edit
#                                            user GET    /users/:id(.:format)                                                           users#show
#                                                 PATCH  /users/:id(.:format)                                                           users#update
#                                                 PUT    /users/:id(.:format)                                                           users#update
#                                                 DELETE /users/:id(.:format)                                                           users#destroy
#                                           roles GET    /roles(.:format)                                                               roles#index
#                                                 POST   /roles(.:format)                                                               roles#create
#                                        new_role GET    /roles/new(.:format)                                                           roles#new
#                                       edit_role GET    /roles/:id/edit(.:format)                                                      roles#edit
#                                            role GET    /roles/:id(.:format)                                                           roles#show
#                                                 PATCH  /roles/:id(.:format)                                                           roles#update
#                                                 PUT    /roles/:id(.:format)                                                           roles#update
#                                                 DELETE /roles/:id(.:format)                                                           roles#destroy
#                                    user_session POST   /user_session(.:format)                                                        user_sessions#create
#                                           login GET    /login(.:format)                                                               user_sessions#new
#                                          logout DELETE /logout(.:format)                                                              user_sessions#destroy
#                                                 GET    /auth/:provider/callback(.:format)                                             user_sessions#create
#                                    auth_failure GET    /auth/failure(.:format)                                                        redirect(301, /)
#                                 reset_passwords POST   /reset_passwords(.:format)                                                     reset_passwords#create
#                              new_reset_password GET    /reset_passwords/new(.:format)                                                 reset_passwords#new
#                             edit_reset_password GET    /reset_passwords/:id/edit(.:format)                                            reset_passwords#edit
#                                  reset_password PATCH  /reset_passwords/:id(.:format)                                                 reset_passwords#update
#                                                 PUT    /reset_passwords/:id(.:format)                                                 reset_passwords#update
#

GroupDProject1::Application.routes.draw do

	resources :reports, :maps

  get "maps/main"
  root 'maps#main'

  get "static_pages/contact", :as => 'contact'
  get "static_pages/about", :as => 'about'

	namespace :admin do
		resources :interest_points, :images, only: [:index, :show] do
			put 'update_multiple', on: :collection
			put 'approve', 'unapprove', on: :member
		end
		match 'update_default_image', to: 'interest_points#update_default_image', via: :put
	end
	
	namespace :contributor do
		resources :interest_points, only: [:index, :edit] do
			get 'active', 'pending', on: :collection
			put 'update_default_image'
		end
	end
	
	# Define polymorphic comments as a concern
	concern :commentable do
		resources :comments, only: [:index, :new, :create, :delete]
	end

  # Define polymorphic ratings as a concern
  concern :ratable do
	  resources :ratings, only: [:update]
  end
  

  # Interest Points routes for actions taken for a specific POI instance and nested Comments
	resources :interest_points do
		concerns :commentable, :ratable
		resources :images, only: [:index, :create, :new, :destroy]
	end  
  
  resources :artists
	
	resources :categories, concerns: :commentable
	
	match 'reported_comments', to: 'comments#reported', via: [:get]
	
	# Route for account and current user login/logout
	resources :users, :roles
	resource :user_session, only: :create
	match 'login', to: 'user_sessions#new', via: [:get]
	match 'logout', to: 'user_sessions#destroy', via: [:delete]
	
  get '/auth/:provider/callback', to: 'user_sessions#create'
  get 'auth/failure', to: redirect('/')
  	
 	# Map password reset actions
 	resources :reset_passwords, only: [:new, :create, :edit, :update]

 end
