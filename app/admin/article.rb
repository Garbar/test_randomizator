ActiveAdmin.register Article do
  index :title=>'Статьи', :download_links => false do
    column 'Название', :title
    column 'Город', :city
    column 'Сайт', :site
    column 'Дата последнего изменения', :updated_at
    actions
  end
  form do |f|
    f.inputs "Статья" do
      f.input :city, :label => "Город"
      f.input :site, :label => "Сайт"
      f.input :title, :label => "Название"
      f.input :description, :label => 'Краткое описание'
      f.input :text, :label => 'Полное описание'
    end


    f.actions
  end
  permit_params :title, :city_id,
    :text, :description, :site_id

end
