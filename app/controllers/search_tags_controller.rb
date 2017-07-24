class SearchTagsController < ApplicationController
  def index
    @search = Tag.search(params[:search_word]).page(params[:page])
    @search_word = params[:search_word]
  end
end
