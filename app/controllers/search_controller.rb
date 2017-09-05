class SearchController < ApplicationController
  def index
    @search_form = SearchForm.new(search_word: params[:search_word])
    @feed = @search_form.search
    unless @feed.empty?
      @feed = Kaminari.paginate_array(@feed).page(params[:page])
    end
    @search_word = params[:search_word]
    @tag = Tag.new
  end
end
