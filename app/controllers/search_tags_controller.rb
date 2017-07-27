class SearchTagsController < ApplicationController
  def index
    @word = SearchForm.new(search_word: params[:search_word])
    if @word.valid?
      @search = @word.search.page(params[:page])
    else
      @search = Tag.none.page(params[:page])
      flash[:danger] = "word is blank"
    end
      @search_word = params[:search_word]
      @tag = Tag.new
  end
end
