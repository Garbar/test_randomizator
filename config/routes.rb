Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  scope controller: :articles do
    get ":city_url/articles"  => :index, as: 'articles'
    get ":city_url/articles/:id" => :show, as: 'article'
  end

  match '(:city_url)', to: 'main#index', as: 'main', via: [:get, :post]

end
