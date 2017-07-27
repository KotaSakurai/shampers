class SearchForm
  include ActiveModel::Model
  SPECIFY_TAG_REGEX = /#([\w\d_-]+)/

  attr_accessor :search_word
  validates :search_word, presence: true

  def search
    if valid?
      tag_search = search_word.match(SPECIFY_TAG_REGEX)
      if tag_search
        Tag.search(tag_search[1])
        binding.pry
      else
        Shampoo.search(search_word)
        binding.pry
      end
    else
      false
    end
  end
end
