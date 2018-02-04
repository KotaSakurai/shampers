class SearchForm
  include ActiveModel::Model

  SPECIFY_TAG_REGEX = /^#(.*)/

  attr_accessor :search_word

  validates :search_word, presence: true

  def invalid?
    !valid?
  end

  def search
    return Shampoo.none if invalid?
    if tag_search?(search_word)
      search_word.slice!(0)
      shampoo_with_tag(search_word)
    else
      Shampoo.where(name: search_word)
    end
  end

  private
    def tag_search?(search_word)
      return true if search_word.match(SPECIFY_TAG_REGEX)
      false
    end

    def shampoo_with_tag(tag_name)
      Tag.where(name: tag_name).map do |tag|
        tag.shampoo
      end
    end
end
