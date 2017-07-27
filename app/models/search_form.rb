class SearchForm
  include ActiveModel::Model
  SPECIFY_TAG_REGEX = /#([\w\d_-]+)/

  attr_accessor :search_word
  validates :search_word, presence: true

  def search
    if valid?
      tag_search = search_word.match(SPECIFY_TAG_REGEX)
      if tag_search
        tags = Tag.search(tag_search[1])
        tags.map do |tag|
          tag.shampoo
        end
      else
        Shampoo.search(search_word)
      end
    else
      []
    end
  end
end
