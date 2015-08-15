ActiveAdmin.register Randomizator do
  menu :label => "Рандомизатор статей"

  filter :site, :label => 'Сайт'

  index :title=>'Тексты для рандомизатора', :download_links => false do
    column 'Название', :title
    column 'Сайт', :site
    column 'Дата последнего изменения', :updated_at
    actions
  end
  form do |f|
    f.inputs "Рандомизатор" do
      f.input :site, :label => "Сайт"
      f.input :title, :label => "Название"
      f.input :text, :label => 'Текст'
    end
    f.actions
  end
  permit_params :title,
    :text,  :site_id

  action_item only: :show do
    link_to 'Create articles', publish_admin_randomizator_path(randomizator), :method => :post
  end

  member_action :publish, method: 'post' do
    randomizator = Randomizator.find(params[:id])
    randomizator.create_articles
    redirect_to admin_randomizator_path(randomizator), notice: 'Articles has been create successfully!'
  end
end
