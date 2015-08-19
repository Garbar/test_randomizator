class Randomizator < ActiveRecord::Base
  include HTTParty
  belongs_to :site
  before_save :generate_new_text
  validates :title, presence: true
  validates :site_id, presence: true
  # validates :text, presence: true, :unless => proc{|obj| obj.text.blank?}
  # validates :stext, presence: true, :unless => proc{|obj| obj.stext.blank?}

  validate :text_xor_stext

  enum wheretext: [:new_text]
  def create_articles
    City.all.each do |c|
      # result = self.text.gsub(/\{\[(.*?)\](\[(.*?)\])*\}/){random_word($1, $3)}
      result = self.stext.present? ? self.stext.gsub(/\{(.*?)\}/){random_new_word($1)} : self.newtext = self.text.gsub(/\{\[(.*?)\](\[(.*?)\])*\}/){random_word($1, $3)}
      @article = Article.create!({title: self.title, text: result, description: result.truncate_words(20), city_id: c.id, site_id:self.site_id, url: self.title.parameterize })
    end
    # result = self.stext.present? ? self.stext.gsub(/\{(.*?)\}/){random_new_word($1)} : self.newtext = self.text.gsub(/\{\[(.*?)\](\[(.*?)\])*\}/){random_word($1, $3)}
    # result = text.gsub(/\{\[(.*?)\](\[(.*?)\])*\}/){random_word($1, $3)}
    # @article = Article.create!({title: self.title, text: result, description: result.truncate_words(20), city_id: 1, site_id:self.site_id, url: self.title.parameterize })
  end



  def generate_new_text
    if wheretext == 'new_text'
      self.newtext = ''
      if self.stext.present?
        self.newtext = self.stext.gsub(/\{(.*?)\}/){random_new_word($1)}
      else
        self.newtext = self.text.gsub(/\{\[(.*?)\](\[(.*?)\])*\}/){random_word($1, $3)}
      end
    end
  end
  def random_new_word(w)
    arr = w.split('|')
    arr.sample
  end

  def random_word(word, mod)
    api_key = Rails.application.secrets.yandex_key
    syn = []
    words = URI.encode(word)
    response = HTTParty.get("https://dictionary.yandex.net/api/v1/dicservice.json/lookup?key=#{api_key}&lang=ru-ru&text=#{words}")
    k = JSON.parse(response.body)["def"]
    if k.size > 0
      j = k[0]["tr"]
      j.each {|x| x["syn"].each {|y| syn << y["text"]} if x["syn"]}
      word = syn.sample
    end
    if mod
      # byebug
      if word
        # text = Morpher.new(word)
        # modif_word(text, mod)
        # byebug
        if mod.match(/Мн/)
          word  = Russian::Pluralize.pluralize(word)
        end
        if mod.match(/Р/)
          word = RussianInflect.inflect(word, :genitive)
        end
        if mod.match(/Д/)
          word = RussianInflect.inflect(word, :dative)
        end
        if mod.match(/В/)
          word = RussianInflect.inflect(word, :accusative)
        end
        if mod.match(/Т/)
          word = RussianInflect.inflect(word, :instrumental)
        end
        if mod.match(/П/)
          word = RussianInflect.inflect(word, :prepositional)
        end
        # words = RussianInflect.new(word)
        # byebug
        # inflect_word(words, mod)
        if mod.match(/Б/)
          word  = word.mb_chars.capitalize.to_s
        end
      end
    end
    word
  end
  def inflect_word(word, mod)
    case mod
    when /(И)/
      # word = RussianInflect.inflect(word, :nominative)
    when /(Р)/
      # word = RussianInflect.inflect(word, :genitive)
      word = word.to_case :genitive
    when /(Д)/
      # word = RussianInflect.inflect(word, :dative)
      word = word.to_case :dative
        word
      end
end
  def modif_word(text, m)
    # text = Morpher.new(w.to_s)
    if m.match(/Мн/)
      case m
      when /(И)/
          w = text.plural('И')
       when /(Р)/
          w = text.plural('Р')
        when /(Д)/
          w = text.plural('Д')
        when /(В)/
           w = text.plural('В')
        when /(Т)/
          w = text.plural('Т')
        when /(П)/
           w = text.plural('П')
        when /(П_о)/
           w = text.plural('П_о')
        when /(где)/
           w = text.plural('где')
        when /(когда)/
           w = text.plural('когда')
            when /(откуда)/
           w = text.plural('откуда')
        # else
        #   w = nill
      end
    else
        case m
        when /(Р)/
          w = text.singular('Р')
        when /(Д)/
          w = text.singular('Д')
        when /(В)/
          w = text.singular('В')
        when /(Т)/
           w = text.singular('Т')
        when /(П)/
          w = text.singular('П')
        when /(П_о)/
          w = text.singular('П_о')
        when /(где)/
          w = text.singular('где')
        when /(когда)/
          w = text.singular('когда')
         when /(откуда)/
          w = text.singular('откуда')
        # else
        #  w = nill
      end
    end
    w
end

  private
    def text_xor_stext
      if !(text.blank? ^ stext.blank?)
        errors[:base] << "Заполните обязательно только одно из полей с текстами для преобразования"
      end
    end

end
