class SearchController < ApplicationController
  def index
    @search_word = SearchForm.new(search_word: params[:search_word])
    if @search_word
      binding.pry
      @feed = @search_word.search.page(params[:page])
    else
      @feed = @search_word.none.page(params[:page])
    end

    @search_word = params[:search_word]
    @tag = Tag.new
  end
end
