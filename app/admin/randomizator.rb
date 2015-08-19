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
      # f.semantic_errors *f.object.errors.keys
      f.semantic_errors :base
      f.input :title, :label => "Название"
      f.input :site, :label => "Сайт"
      f.input :wheretext, :label => "Действия с текстом",
        :as => :select,
        :include_blank => "Только сохранить текст",
        :collection =>{'Преобразовать текст в новом поле' => 'new_text'}
      f.input :text, :label => 'Текст для преобразования', :hint => 'Синонимы берутся с Яндекс словарей'
      f.input :stext, :label => 'Текст для преобразования', :hint => 'Синонимы добавляются пользователей  в виде массива возможжных вариантов'
      f.input :newtext, :label => 'Текст после замены слов'
    end
    f.actions
  end
  permit_params :title,
    :text,  :site_id, :wheretext, :stext, :newtext

  action_item only: :show do
    link_to 'Create articles', publish_admin_randomizator_path(randomizator), :method => :post
  end

  member_action :publish, method: 'post' do
    randomizator = Randomizator.find(params[:id])
    randomizator.delay.create_articles
    # randomizator.create_articles
    redirect_to admin_randomizator_path(randomizator), notice: 'Articles has been create successfully!'
  end
end
