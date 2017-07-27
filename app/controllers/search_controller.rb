class SearchController < ApplicationController
  def index
    @search_word = SearchForm.new(search_word: params[:search_word])
    if @feed = @search_word.search
      @feed = Kaminari.paginate_array(@feed).page(params[:page])
    end
    @search_word = params[:search_word]
    @tag = Tag.new
  end
end
