class SearchTagsController < ApplicationController
  def index
    @search = Tag.search(params[:search_word])
  end
end
