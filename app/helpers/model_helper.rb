# encoding: utf-8
module ModelHelper
  def translit(string)
     transliteration={'а'=>'a','б'=>'b','в'=>'v','г'=>'g','д'=>'d','е'=>'e','ё'=>'yo','ж'=>'zh',
'з'=>'z','и'=>'i','й'=>'y','к'=>'k','л'=>'l','м'=>'m','н'=>'n','о'=>'o','п'=>'p','р'=>'r',
'с'=>'s','т'=>'t','у'=>'u','ф'=>'f','х'=>'kh','ц'=>'ts','ч'=>'ch','ш'=>'sh','щ'=>'sch','ъ'=>'',
'ы'=>'y','ь'=>"",'э'=>'e','ю'=>'yu','я'=>'ya',' '=>'_','a'=>'a','b'=>'b','c'=>'c','d'=>'d','e'=>'e',
'f'=>'f','g'=>'g','h'=>'h','i'=>'i','j'=>'j','k'=>'k','l'=>'l','m'=>'m','n'=>'n','o'=>'o','p'=>'p',
'q'=>'q','r'=>'r','s'=>'s','t'=>'t','u'=>'u','v'=>'v','w'=>'w','x'=>'x','y'=>'y','z'=>'z',
'0'=>'0','1'=>'1','2'=>'2','3'=>'3','4'=>'4','5'=>'5','6'=>'6','7'=>'7','8'=>'8','9'=>'9', '_'=>'_'}
  
    string.mb_chars.downcase.chars.map {|c| transliteration[c] || ''}.join
  end
  
  
  def generate_url
    if self.url.empty?
      self.url = translit self.title
    else
      self.url = translit self.url
    end
  end
end