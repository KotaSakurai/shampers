class SearchTagsController < ApplicationController
  def index
    @search = Tag.search(params[:search_word]).page(params[:page])
    @search_word = params[:search_word]
    @tag = Tag.new
  end

  def create
    @tag = current_user.tags.build(tag_params)
    if @tag.save
      flash[:info] = "Posted Shampoo!"
      redirect_to root_path
    else
      flash[:denger] = "You couldn't post"
      redirect_to root_url
    end
  end
end
