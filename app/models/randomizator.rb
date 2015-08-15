class Randomizator < ActiveRecord::Base
  include HTTParty
  belongs_to :site
  def create_articles
    City.all.each do |c|
      # result = self.text.gsub(/\{(.*?)\}/){random_word($1)}
      result = self.text.gsub(/\{\[(.*?)\](\[(.*?)\])*\}/){random_word($1, $3)}
      @article = Article.create!({title: self.title, text: result, description: result.truncate_words(20), city_id: c.id, site_id:self.site_id, url: self.title.parameterize })
    end
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
      # p text = MorpherInflect.inflections(word)
    end
    if mod
      # modif_word(mod)
      if mod.match(/Б/)
        word  = word.mb_chars.capitalize.to_s
      end
    end
    word
  end

  def modif_word(w)
    if w.match(/Мн/)
      case w
      when /(Р)/

        when /(Д)/

        when /(В)/

        when /(Т)/

        when /(П)/

        when /(П_о)/

        when /(где)/

        when /(когда)/

        else
          print "something plural"
      end
    else
        case w
        when /(Р)/

        when /(Д)/

        when /(В)/

        when /(Т)/

        when /(П)/

        when /(П_о)/

        when /(где)/

        when /(когда)/

        else
          print "something singular"
      end
    end
end
end
